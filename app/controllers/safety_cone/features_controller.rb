require_dependency 'safety_cone/application_controller'

module SafetyCone
  class FeaturesController < ApplicationController
    def update
      feature = SafetyCone.features[params[:id].to_i]

      redis = SafetyCone.redis
      redis_key = "safety::cone::#{feature[:feature]}"
      redis.set(redis_key, params[:state])

      redirect_to cones_path
    end
  end
end
