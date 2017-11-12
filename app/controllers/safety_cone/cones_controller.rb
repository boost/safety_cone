require_dependency 'safety_cone/application_controller'

module SafetyCone
  class ConesController < ApplicationController
    def index
      @paths = SafetyCone.paths
      @features = SafetyCone.features
    end
  end
end
