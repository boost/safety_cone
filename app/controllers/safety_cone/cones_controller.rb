require_dependency 'safety_cone/application_controller'

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
  end
end
