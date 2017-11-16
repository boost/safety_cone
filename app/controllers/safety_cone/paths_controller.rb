require_dependency 'safety_cone/application_controller'

module SafetyCone
  class PathsController < ApplicationController
    def edit
      path = SafetyCone.paths[params[:id].to_sym]
      @path = Path.new(params[:id], path)
      @path.fetch
    end

    def update
      path = SafetyCone.paths[params[:id].to_sym]
      mereged_params = path.merge(params[:path].symbolize_keys)
      Path.new(params[:id], mereged_params).save

      redirect_to cones_path
    end
  end
end
