class RecipesController < ApplicationController
  def index

  end

  def create
    @recipe = Recipe.new(recipe_params)
    @recipe.user = current_user

    if @recipe.save
      redirect_to recipes_path
    else
      render :index
    end
  end

  def update

  end

  def destroy

  end

  private

  def recipe_params
    params.require(:recipe).permit(:comments)
  end
end
