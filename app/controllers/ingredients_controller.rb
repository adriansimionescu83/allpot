class IngredientsController < ApplicationController
  def index
    @ingredient = policy_scope(Ingredient).new
    @ingredients = policy_scope(Ingredient).where(user_id: current_user.id)
    @categories = Ingredient::CATEGORY
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
    authorize @ingredient

    @ingredient.destroy

    current_user.call_api_recipes = true # When new ingredients are updated this qualifies the user for a new API Call
    current_user.save

    redirect_to ingredients_path
  end

  def build_shopping_list
    checked_ingredients = params[:recipe][:ingredients]
    checked_ingredients.each do |ingredient|
      ingredient.is_available = 'false'
      ingredient.save
    end


    redirect_to shopping_list_path

    authorize @ingredients
  end

  private

  def ingredient_find
    @ingredient = policy_scope(Ingredient).find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :measure, :category, :quantity)
  end
end
