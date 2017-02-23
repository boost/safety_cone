SafetyConeMountable::Engine.routes.draw do
	root to: 'cones#index'
	resources :cones, only: [:index, :show, :update]
end
