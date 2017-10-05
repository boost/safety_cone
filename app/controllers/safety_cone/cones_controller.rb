require_dependency "safety_cone/application_controller"

module SafetyCone
  class ConesController < ApplicationController
    unless Rails.env.test?
      http_basic_authenticate_with name: SafetyCone.auth[:username],
        password: SafetyCone.auth[:password] if (SafetyCone.auth[:username] && SafetyCone.auth[:password])
    end

    def index
      @cones = SafetyCone.cones
    end

    def edit
      cone = SafetyCone.cones[params[:id].to_sym]
      @cone = Cone.new(params[:id], cone)
      @cone.fetch
    end

    def update
      cone = SafetyCone.cones[params[:id].to_sym]
      mereged_params = cone.merge(cone_params.to_h.symbolize_keys)
      Cone.new(params[:id], mereged_params).save

      redirect_to cones_path
    end

    private

    def cone_params
      params.require(:cone).permit(:message, :measure)
    end
  end
end
