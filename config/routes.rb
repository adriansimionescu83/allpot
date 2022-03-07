Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/user' => "recipes#index", :as => :user_root
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :recipes, only: [:index, :show, :update]
  resources :ingredients, only: %i[index create update destroy]

  get 'recipes/:id/cooked', to: 'recipes#cooked'
  get 'recipes/:id/back', to: 'recipes#back'

  get 'my_recipes', to: 'recipes#my_recipes'
  patch 'shopping_list', to: 'ingredients#build_shopping_list', as: :build_shopping_list
  get 'shopping_list', to: 'ingredients#shopping_list', as: :shopping_list


end
