SafetyCone::Engine.routes.draw do
	root to: 'cones#index'
	resources :cones, only: [:index, :edit, :update]
  resources :features, only: [:update]
end
