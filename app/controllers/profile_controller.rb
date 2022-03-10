class ProfileController < ApplicationController
  skip_after_action :verify_authorized
  def show
  end

  def update
    if params[:user].nil?
      @diet = []
      @intolerances = []
    else
      @diet = params[:user][:diet]
      @intolerances = params[:user][:intolerances]
    end

    unless (@diet.equal? current_user.diet) && (@intolerances.equal? current_user.intolerances)
      current_user.update(diet: @diet, intolerances: @intolerances, call_api_recipes: true)
    end

    redirect_to recipes_path
  end
end
