class ProfileController < ApplicationController
  skip_after_action :verify_authorized
  def show

  end

  def update
    @diet = params[:user][:diet]
    @intolerances = params[:user][:intolerances]
    current_user.call_api_recipes = true if current_user.update(diet: @diet, intolerances: @intolerances)

    redirect_to user_profile_path
  end
end
