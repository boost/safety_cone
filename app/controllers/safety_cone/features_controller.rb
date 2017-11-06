require_dependency "safety_cone/application_controller"

module SafetyCone
  class FeaturesController < ApplicationController
    unless Rails.env.test?
      http_basic_authenticate_with name: SafetyCone.auth[:username],
        password: SafetyCone.auth[:password] if (SafetyCone.auth[:username] && SafetyCone.auth[:password])
    end

    def update
      feature = SafetyCone.features[params[:id].to_i]

      redis = SafetyCone.redis
      redis_key = "safety::cone::#{feature[:feature]}"
      redis.set(redis_key, params[:state])

      # binding.pry
      # feature = SafetyCone.features[params[:id]]
      # mereged_params = path.merge(params[:path].symbolize_keys)
      # Cone.new(params[:id], mereged_params).save

      redirect_to cones_path
    end
  end
end
