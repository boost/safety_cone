require_dependency "safety_cone_mountable/application_controller"

module SafetyConeMountable
  class ConesController < ApplicationController
    def index
      @cones = SafetyConeMountable.cones
    end

    def edit
      cone = SafetyConeMountable.cones[params[:id].to_sym]
      @cone = Cone.new(params[:id], cone)
    end

    def update
      @cone = SafetyConeMountable.cones[params[:id].to_sym]
      redirect_to cones_path
    end
  end
end
