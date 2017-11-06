require_dependency "safety_cone/application_controller"

module SafetyCone
  class ConesController < ApplicationController
    unless Rails.env.test?
      http_basic_authenticate_with name: SafetyCone.auth[:username],
        password: SafetyCone.auth[:password] if (SafetyCone.auth[:username] && SafetyCone.auth[:password])
    end

    def index
      @paths = SafetyCone.paths
      @features = SafetyCone.features
    end

    def edit
      path = SafetyCone.paths[params[:id].to_sym]
      @path = Cone.new(params[:id], path)
      @path.fetch
    end

    def update
      path = SafetyCone.paths[params[:id].to_sym]
      mereged_params = path.merge(params[:path].symbolize_keys)
      Cone.new(params[:id], mereged_params).save

      redirect_to cones_path
    end
  end
end
