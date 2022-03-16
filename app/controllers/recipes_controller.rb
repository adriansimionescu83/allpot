require "json"
require "open-uri"
require 'date'

class RecipesController < ApplicationController

  def index
    get_ingredients
    call_api if current_user.call_api_recipes
    @recipes = policy_scope(Recipe).where(user_id: current_user.id).order(missed_ingredients_count: :asc)
    @user = current_user

    if params[:query].present?
      @recipes = Recipe.global_search(params[:query])
    end
  end

  def favorites
    @recipe = Recipe.find(params[:id])

    if @recipe.favorite == false
     @recipe.favorite = true
    else @recipe.favorite == true
     @recipe.favorite = false
    end

    authorize @recipe
    if @recipe.save
      { errors: [] }.to_json
    else
      { errors: errors.messages }.to_json
    end

  end

  def my_recipes
    @recipes = policy_scope(Recipe).where(user_id: current_user.id, status: 'cooked')
    @favorite_recipes = policy_scope(Recipe).where(user_id: current_user.id, favorite: true)
    authorize @recipes
  end


  def cooked
    @recipe = Recipe.find(params[:id])
    @recipe.update(status: 'cooked')
    redirect_to recipes_path

    authorize @recipe
  end

  def destroy
    @recipe = Recipe.find(params[:id])
    authorize @recipe
  end

  def show
    @recipe = Recipe.find(params[:id])
    @recipe.update(comments: params[:comments])

    @ingredients = @recipe.recipe_ingredients
    create_recipe_ingredients(@recipe) unless @recipe.recipe_ingredients.count > 0
    authorize @recipe
  end

  private

  def get_ingredients
    @ingredients = ''
    available_ingredients = current_user.ingredients.select { |item|  item.is_available }
    available_ingredients.each do |ingredient|
      if ingredient == available_ingredients.last
        @ingredients += "#{ingredient.name.downcase}"
      else
       @ingredients += "#{ingredient.name.downcase},"
      end
    end
  end

  def call_api
    if current_user.diet.nil?
      diet = ''
    else
      diet = current_user.diet.join(',').downcase
    end
    if current_user.intolerances.nil?
      intolerances = ''
    else
      intolerances = current_user.intolerances.join(',').downcase
    end
    ignore_pantry = 'false' #Whether to ignore typical pantry items, such as water, salt, flour, etc.
    sort_by = 'min-missing-ingredients' #More options on sorting here https://spoonacular.com/food-api/docs#Recipe-Sorting-Options
    sort_direction = 'asc'
    api_key = ENV["SPOONTACULAR_API_KEY"]
    @url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=#{api_key}&number=10&includeIngredients=#{@ingredients}&addRecipeInformation=true&sort=#{sort_by}&sortDirection=#{sort_direction}&fillIngredients=true&diet=#{diet}&intolerances=#{intolerances}&ignorePantry=#{ignore_pantry}"
    recipes_serialized = URI.parse(@url).read
    recipes = JSON.parse(recipes_serialized)["results"]
    if !recipes.empty?
      Recipe.where(status: 'uncooked', favorite: false).destroy_all #removes all recipes that are not cooked so that these are replaced with the new matches found by API
      Recipe.where(status: 'cooked').update(is_latest_result: false) #marks all existing recipes that are cooked as old records
      # Recipe.where(favorite: true).update(is_latest_result: false) #marks all existing recipes that are favorites as old records
    end

    recipes.each do |recipe|
      if Recipe.exists?(api_record_id: recipe["id"])
        update_recipe_from_api(recipe)
      else
        create_recipe_from_api(recipe)
      end
    end

     current_user.call_api_recipes = false
     current_user.save
     @last_call_time = DateTime.now
  end

  def create_recipe_from_api(recipe)
    description_field = ""
    description_steps = []
    if !recipe["analyzedInstructions"][0].nil?
      recipe["analyzedInstructions"][0]["steps"].each do |step |
        description_steps << "<b>Step #{step["number"]}:</b><br>#{step["step"]}"
        description_field += "<b>Step #{step["number"]}:</b><br>#{step["step"]}"
      end
    end

    # description_field = ""
    # recipe["analyzedInstructions"][0]["steps"].each do |step |
    #   description_field += "<b>Step #{step["number"]}:</b><br>#{step["step"]}<br><br>"
    # end

   new_recipe = Recipe.create(
      api_record_id: recipe["id"],
      status: 'uncooked',
      user_id: current_user.id,
      title: recipe["title"],
      image_url: recipe["image"],
      missed_ingredients_count: recipe["missedIngredientCount"],
      used_ingredients_count: recipe["usedIngredientCount"],
      unused_ingredients_count: recipe["unusedIngredientCount"],
      ready_in_minutes: recipe["readyInMinutes"],
      servings: recipe["servings"],
      summary: recipe["summary"],
      overall_score: recipe["overalScore"],
      health_score: recipe["healthScore"],
      description: description_field,
      missed_ingredients: missed_ingredients(recipe),
      unused_ingredients: unused_ingredients(recipe),
      used_ingredients: used_ingredients(recipe),
      total_ingredients: total_ingredients(recipe),
      aggregate_likes: recipe["aggregateLikes"],
      source_url: recipe["sourceUrl"],
      steps: description_steps,
      diets: recipe["diets"]
      )
  end

  def unused_ingredients(recipe)
    unused_ingredients = []
    recipe["unusedIngredients"].each do |ingredient|
      unused_ingredients << ingredient["name"]
    end
    return unused_ingredients
  end

  def total_ingredients(recipe)
    total_ingredients = []
    recipe["extendedIngredients"].each do |ingredient|
      total_ingredients <<  "#{ingredient["measures"]["metric"]["amount"]} #{ingredient["measures"]["metric"]["unitShort"]} <b>#{ingredient["name"]}</b>"
    end
    return total_ingredients
  end

  def used_ingredients(recipe)
    used_ingredients = []
    recipe["usedIngredients"].each do |ingredient|
      used_ingredients << ingredient["name"]
    end
    return used_ingredients
  end

  def missed_ingredients(recipe)
    return recipe["missedIngredients"] if recipe["missedIngredients"].empty?

    recipe["missedIngredients"].map { |ingredient| ingredient["name"] }
  end

  def update_recipe_from_api(recipe)
    existing_recipe = Recipe.find_by api_record_id: recipe["id"]

    existing_recipe.update(
      missed_ingredients_count: recipe["missedIngredientCount"],
      used_ingredients_count: recipe["usedIngredientCount"],
      unused_ingredients_count: recipe["unusedIngredientCount"],
      overall_score: recipe["overalScore"],
      health_score: recipe["healthScore"],
      is_latest_result: true,
      aggregate_likes: recipe["aggregateLikes"],
      missed_ingredients: missed_ingredients(recipe),
      unused_ingredients: unused_ingredients(recipe),
      used_ingredients: used_ingredients(recipe)
      )
  end

  def recipe_params
    params.require(:recipe).permit(:comments)
  end

  def create_recipe_ingredients(recipe)
    current_user.ingredients.each do |pantry_ingredient|
      recipe.used_ingredients.each do |used_ingredient|
       if used_ingredient.downcase.split(" ").any? {|ingredient| pantry_ingredient.name.include? ingredient} || pantry_ingredient.name.downcase.split(" ").any? {|ingredient| used_ingredient.include? ingredient}
        RecipeIngredient.create(
            ingredient_id: pantry_ingredient.id,
            recipe_id: recipe.id
          )
       end
      end
    end
  end
end
