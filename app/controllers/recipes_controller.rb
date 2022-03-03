require "json"
require "open-uri"
require 'date'

class RecipesController < ApplicationController

  def index
    get_ingredients
    call_api if current_user.call_api_recipes
    @recipes = policy_scope(Recipe)
    @user = current_user
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

    authorize @recipe
  end

  private

  def get_ingredients
    @ingredients = ''
    current_user.ingredients.each do |ingredient|
      if ingredient == current_user.ingredients.last
        @ingredients += "#{ingredient.name.downcase}"
      else
       @ingredients += "#{ingredient.name.downcase},"
      end
    end
  end

  def call_api
    api_key = ENV["SPOONTACULAR_API_KEY"]
    @url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=#{api_key}&number=10&includeIngredients=#{@ingredients}&addRecipeInformation=true&sort=max-used-ingredients&sortDirection=desc&fillIngredients=true"
    recipes_serialized = URI.parse(@url).read
    recipes = JSON.parse(recipes_serialized)["results"]

    Recipe.where(status: 'uncooked').destroy_all #removes all recipes that are not cooked so that these are replaced with the new matches found by API
    Recipe.where(status: 'cooked').update(is_latest_result: false) #marks all existing recipes that are cooked as old records

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
      steps: description_steps
      )
      used_recipe_ingredients(new_recipe, recipe)
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
      total_ingredients << ingredient["name"]
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
    missed_ingredients = []
    recipe["missedIngredients"].each do |ingredient|
      missed_ingredients << ingredient["name"]
    end
    return missed_ingredients
  end

  def used_recipe_ingredients(new_recipe, recipe)
    current_user.ingredients.each do |pantry_ingredient|
      used_ingredient = recipe["usedIngredients"].find { |used_ingredient| used_ingredient["name"].include?(pantry_ingredient.name.downcase) }

      if !used_ingredient.nil?

        RecipeIngredient.create(
          ingredient_id: pantry_ingredient.id,
          recipe_id: new_recipe.id
        )
      end
    end
  end

  def update_recipe_from_api(recipe)
    existing_recipe = Recipe.find(api_record_id: recipe["id"])

    existing_recipe.update(
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
      description: total_steps,
      is_latest_result: true
      )
      used_ingredients(new_recipe, recipe)
  end

  def recipe_params
    params.require(:recipe).permit(:comments)
  end
end
