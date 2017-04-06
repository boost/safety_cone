require_dependency "safety_cone_mountable/application_controller"

module SafetyConeMountable
  class ConesController < ApplicationController
    if Rails.env.production?
    http_basic_authenticate_with name: SafetyConeMountable.auth[:username],
                                 password: SafetyConeMountable.auth[:password] if (SafetyConeMountable.auth[:username] && SafetyConeMountable.auth[:password])
    end

    def index
      @cones = SafetyConeMountable.cones
    end

    def edit
      cone = SafetyConeMountable.cones[params[:id].to_sym]
      @cone = Cone.new(params[:id], cone)
      @cone.fetch
    end

    def update
      cone = SafetyConeMountable.cones[params[:id].to_sym]
      mereged_params = cone.merge(params[:cone].symbolize_keys)
      Cone.new(params[:id], mereged_params).save

      redirect_to cones_path
    end
  end
end
