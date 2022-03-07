Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  get '/user' => "recipes#index", :as => :user_root
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :recipes, only: [:index, :show, :update]   #For now I have not added the cooked path because we might use index to show the cooked recipes
  resources :ingredients, only: %i[index create update destroy]
  get 'recipes/:id/cooked', to: 'recipes#cooked'
  get 'my_recipes', to: 'recipes#my_recipes'



end
