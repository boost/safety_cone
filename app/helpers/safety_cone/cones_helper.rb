module SafetyCone
  module ConesHelper
    include ViewHelpers

    def status(key)
      cone = Path.new(key, {})
      cone.fetch
      cone.type
    end

    def feature_status(key)
      feature?(key)
    end
  end
end
