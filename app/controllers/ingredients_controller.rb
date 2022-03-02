class IngredientsController < ApplicationController

  def index
    @ingredients = policy_scope(ingredient).order(create_at: :desc)
  end

  def create
    @ingredient = ingredient.new(ingredient_params)
  end

  def update

  end

  def destroy

  end

  private

  def ingredient_find
    @ingredient = ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :measure, :category, :quantity)
  end
end
