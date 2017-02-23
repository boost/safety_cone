require_dependency "safety_cone_mountable/application_controller"

module SafetyConeMountable
  class ConesController < ApplicationController
    def index
      @cones = SafetyConeMountable.cones
    end
  end
end
