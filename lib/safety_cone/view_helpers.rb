module SafetyCone
  # Module for Filtering requests and raise notices
  # and take measures
  module ViewHelpers
    def safetycone_notice
      flash[:safetycone_notice]
    end

    def safetycone_alert
      flash[:safetycone_alert]
    end

    def safetycone_feature?(name)
      redis = SafetyCone.redis
      redis_key = "safety::cone::#{name}"
      value = redis.get(redis_key)

      return false unless value

      value == '1'
    end

    def self.add_method(name)
      define_method("#{name}?") { safetycone_feature?(name) }
    end
  end
end

ActionView::Base.send :include, SafetyCone::ViewHelpers
