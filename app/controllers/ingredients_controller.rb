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
      current_user.save!
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

    current_user.call_api_recipes = true # When new ingredients are updated this qualifies the user for a new API Call
    current_user.save

    redirect_to ingredients_path
    authorize @ingredient

  end

  def build_shopping_list
    @ingredients = current_user.ingredients.where(id: params[:recipe][:ingredients])
    unless @ingredients.empty?
      @ingredients.update_all(is_available: false)
      current_user.call_api_recipes = true
      current_user.save
    end

    authorize @ingredients

    redirect_to recipes_path
  end

  def add_to_shopping_list
    @ingredient = Ingredient.find(params[:id])
    @ingredient.update(is_available: false)
    @ingredient.save
    current_user.call_api_recipes = true
    current_user.save

    authorize @ingredient

    redirect_to ingredients_path
  end

  def create_shopping_list_item
    @ingredient = Ingredient.new(ingredient_params)
    @ingredient.user = current_user
    @ingredient.is_available = false
    @ingredient.save

    authorize @ingredient
    redirect_to shopping_list_path
  end

  def shopping_list
    @shopping_list_ingredient = Ingredient.new

    @ingredients = current_user.ingredients.where(is_available: false)
    authorize @ingredients

  end

  def move_to_pantry
    @ingredients = params[:user][:ingredients]
    @ingredients.each do |ingredient|
      @ingredient = Ingredient.find(ingredient.to_i)
      @ingredient.is_available = true
      @ingredient.save
    end

    current_user.call_api_recipes = true
    current_user.save

    authorize @ingredient

    redirect_to ingredients_path
  end

  private

  def ingredient_find
    @ingredient = policy_scope(Ingredient).find(params[:id])
  end

  def ingredient_params
    params.require(:ingredient).permit(:name, :category)
  end


end
