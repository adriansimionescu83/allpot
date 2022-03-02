require "json"
require "open-uri"

class RecipesController < ApplicationController

  def index
    call_api if current_user.call_api_recipes
    @recipes = policy_scope(Recipe)
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

  def call_api

    api_key = ENV["SPOONTACULAR_API_KEY"]
    url = "https://api.spoonacular.com/recipes/complexSearch?apiKey=#{api_key}&number=10&includeIngredients=eggs,chicken,pasta&addRecipeInformation=true&sort=max-used-ingredients&sortDirection=desc&fillIngredients=true"
    recipes_serialized = URI.parse(url).read
    recipes = JSON.parse(recipes_serialized)["results"]

    recipes.each do |recipe|
      create_recipe_from_api(recipe)
    #  if Recipe.exists?(api_recipe_reference: recipe["id"])
    #   update_recipe_from_api(recipe)
    #  else
    #   create_recipe_from_api(recipe)
    #  end
    end

     current_user.call_api_recipes = false

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

        # t.string "description"
        # t.string "missed_ingredients", default: [], array: true
        # t.string "unused_ingredients", default: [], array: true


  end

  def update_recipe_from_api(recipe)
    # existing_recipe = Recipe.find(api_recipe_reference: recipe["id"])
    #Needs to e completed with the updates to be done on the recipe
  end

  def recipe_params
    params.require(:recipe).permit(:comments)
  end
end
