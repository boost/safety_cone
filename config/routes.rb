SafetyCone::Engine.routes.draw do
  root to: 'cones#index'

  resources :cones, only: [:index]
  resources :paths,  only: [:edit, :update]
  resources :features, only: [:update]
end
