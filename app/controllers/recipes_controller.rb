require "json"
require "open-uri"

class RecipesController < ApplicationController

  def index
    get_ingredients
    call_api if current_user.call_api_recipes
    @recipes = policy_scope(Recipe)
    @user = current_user
  end

  def cooked
    @recipe = Recipe.find(params[:id])
    @recipe.status = 'cooked'

  end

  def destroy
    @recipe = Recipe.find(params[:id])
  end

  def show
    @recipe = Recipe.find(params[:id])
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
    url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=#{api_key}&number=10&includeIngredients=#{@ingredients}&addRecipeInformation=true&sort=max-used-ingredients&sortDirection=desc&fillIngredients=true"
    recipes_serialized = URI.parse(url).read
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
     @last_call_time = Date.now

  end

  def create_recipe_from_api(recipe)
    total_steps = ""
    recipe["analyzedInstructions"][0]["steps"].each do |step |
      total_steps += "Step #{step["number"]}: #{step["step"]}
      "
    end

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
      description: total_steps
      )
        # t.string "missed_ingredients", default: [], array: true
        # t.string "unused_ingredients", default: [], array: true
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
      )    #Needs to e completed with the updates to be done on the recipe
  end

  def recipe_params
    params.require(:recipe).permit(:comments)
  end
end
