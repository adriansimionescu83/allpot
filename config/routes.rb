Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  devise_for :users
  root to: 'pages#home'
  get '/user' => "recipes#index", :as => :user_root
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :recipes, only: %i[index show update] do
    member do
      patch :favorites
    end
  end

  get 'users/profile', to: 'profile#show', as: :user_profile
  patch 'users/profile', to: 'profile#update', as: :update_user_profile

  resources :ingredients, only: %i[index create update destroy]

  get 'recipes/:id/cooked', to: 'recipes#cooked'

  get 'my_recipes', to: 'recipes#my_recipes'
  patch 'shopping_list', to: 'ingredients#build_shopping_list', as: :build_shopping_list
  patch 'ingredients/:id/add_to_shopping_list', to: 'ingredients#add_to_shopping_list', as: :add_to_shopping_list

  patch 'pantry', to: 'ingredients#move_to_pantry', as: :move_to_pantry
  get 'shopping_list', to: 'ingredients#shopping_list', as: :shopping_list
  post 'shopping_list', to: 'ingredients#create_shopping_list_item', as: :create_shopping_list_item

  authenticate :user, ->(user) { user.admin? } do
    mount Blazer::Engine, at: "blazer"
  end
end
