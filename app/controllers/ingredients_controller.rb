class IngredientsController < ApplicationController
  def index
    @ingredients = policy_scope(Ingredient).order(created_at: :desc)
  end

  def create
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.user = current_user

    if @ingredient.save
      current_user.call_api_recipes = true # When new ingredients are updated this qualifies the user for a new API Call
      current_user.save
      redirect_to ingredients_path
    else
      render :index
    end

    authorize @ingredient
  end

  def update
    ingredient_find
    @ingredient.update(ingredient_params)
    @ingredient.save

    current_user.call_api_recipes = true # When new ingredients are updated this qualifies the user for a new API Call
    current_user.save

    redirect_to ingredient_path(@ingredient)

    authorize @ingredient
  end

  def destroy
    ingredient_find
    @ingredient.destroy

    authorize @ingredient
  end

  private

  def ingredient_find
    @ingredient = Ingredient.find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :measure, :category, :quantity)
  end
end
