require "json"
require "open-uri"

class RecipesController < ApplicationController

  def index
    @recipes = policy_scope(Recipe)

    api_key = ENV["SPOONTACULAR_API_KEY"]
    puts api_key
    url = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{api_key}&ingredients=apples,+flour,+sugar&number=2"

    recipes_serialized = URI.parse(url).read
    recipes = JSON.parse(recipes_serialized)

    recipes.each do |recipe|
      puts recipe["id"]
      puts recipe["title"]
    end
  end

  def create

    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to recipes_path
    else
      render :index
    end

    authorize @recipe
  end

  def update

  end

  def destroy

  end

  private
  def call_spoontacular_api
    api_key = ENV["SPOONTACULAR_API_KEY"]
    puts api_key
    url = "https://api.spoonacular.com/recipes/findByIngredients?apiKey=#{api_key}&ingredients=apples,+flour,+sugar&number=2"

    recipes_serialized = URI.parse(url).read
    recipes = JSON.parse(recipes_serialized)

    recipes.each do |recipe|
      new_recipe = Recipe.new(api_recipe_reference: recipe["id"])
     end
  end


  def recipe_params
    params.require(:recipe).permit(:comments)
  end
end
