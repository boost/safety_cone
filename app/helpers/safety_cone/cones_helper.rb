module SafetyCone
  module ConesHelper
    def status(key)
      cone = Path.new(key, {})
      cone.fetch
      cone.type
    end

    def feature_status(key)
      redis = SafetyCone.redis
      redis_key = "safety::cone::#{key}"
      value = redis.get(redis_key)

      return false unless value

      value == '1'
    end
  end
end
