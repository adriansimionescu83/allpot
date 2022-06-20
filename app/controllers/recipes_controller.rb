require "json"
require "open-uri"
require 'date'
require 'faraday'
require 'faraday/net_http'
require 'pry-byebug'
require_relative '../services/api_spoonacular'

class RecipesController < ApplicationController
  Faraday.default_adapter = :net_http
  def index
    link_ingredients
    call_api if current_user.call_api_recipes
    @recipes = policy_scope(Recipe).where(user_id: current_user.id, is_latest_result: true).order(missed_ingredients_count: :asc)
    @user = current_user

    if params[:query].present?
      @recipes = Recipe.global_search(params[:query])
    end
  end

  def favorites
    @recipe = Recipe.find(params[:id])

    @recipe.favorite = !@recipe.favorite
    authorize @recipe

    respond_to do |format|
      if @recipe.save
        format.html {}
        format.json {
          render json: { favorite: @recipe.favorite }
        }
      end
    end
  end

  def my_recipes
    @cooked_recipes = policy_scope(Recipe).where(user_id: current_user.id, cooked: true)
    @favorite_recipes = policy_scope(Recipe).where(user_id: current_user.id, favorite: true)
    authorize @cooked_recipes
    authorize @favorite_recipes
  end

  def cooked
    @recipe = Recipe.find(params[:id])
    @recipe.update(cooked: true)
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

  def link_ingredients
    @ingredients = ''
    available_ingredients = current_user.ingredients.select { |item| item.is_available }
    available_ingredients.each do |ingredient|
      if ingredient == available_ingredients.last
        @ingredients += "#{ingredient.name.downcase}"
      else
        @ingredients += "#{ingredient.name.downcase},"
      end
    end
  end

  def call_api
    recipes = CallSpoonacular.get_recipes( @ingredients, current_user)

    update_or_create_recipes(recipes) unless recipes.empty?
    @last_call_time = DateTime.now
  end

  def update_or_create_recipes(recipes)
    @recipes_array = []
    current_user.update(call_api_recipes: false)
    Recipe.where(user_id: current_user.id, cooked: false, favorite: false).destroy_all
    Recipe.where(is_latest_result: true, user_id: current_user.id).update(is_latest_result: false) # marks all existing recipes that as old records
    recipes.each do |recipe|
      existing_recipe = Recipe.where(api_recipe_reference: recipe["id"]).first
      if existing_recipe
        update_recipe_from_api(recipe, existing_recipe)
      else
        create_recipes_from_api(recipe)
      end
    end
    Recipe.insert_all(@recipes_array)
  end

  def create_recipes_from_api(recipe)
    description_field = ""
    description_steps = []
    unless recipe["analyzedInstructions"][0].nil?
      recipe["analyzedInstructions"][0]["steps"].each do |step|
        description_steps << "<b>Step #{step['number']}:</b><br>#{step['step']}"
        description_field += "<b>Step #{step['number']}:</b><br>#{step['step']}"
      end
    end
    @recipes_array << {
      api_recipe_reference: recipe["id"],
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
      diets: recipe["diets"],
      # vegetarian: recipe["vegetarian"],
      vegan: recipe["vegan"],
      gluten_free: recipe["glutenFree"],
      dairy_free: recipe["dairyFree"],
      ketogenic: recipe["ketogenic"],
      spoonacular_score: recipe["spoonacularScore"],
      credits_text: recipe["creditsText"],
      source_name: recipe["sourceName"],
      cuisines: recipe["cuisines"],
      dish_types: recipe["dishTypes"],
      occasions: recipe["occasions"],
      spoonacular_source_url: recipe["spoonacularSourceUrl"],
      likes: recipe["likes"],
      intolerances: recipe["intolerances"],
      created_at: Time.now,
      updated_at: Time.now
    }
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
      total_ingredients << [
        ingredient['measures']['metric']['amount'],
        ingredient['measures']['metric']['amount'].round,
        ingredient['measures']['metric']['unitShort'],
        ingredient['name']
      ]
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

  def update_recipe_from_api(recipe, existing_recipe)
    existing_recipe.update(
      is_latest_result: true,
      missed_ingredients: missed_ingredients(recipe),
      unused_ingredients: unused_ingredients(recipe),
      used_ingredients: used_ingredients(recipe),
      missed_ingredients_count: recipe["missedIngredientCount"],
      used_ingredients_count: recipe["usedIngredientCount"]
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
