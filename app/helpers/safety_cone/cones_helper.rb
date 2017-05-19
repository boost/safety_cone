module SafetyCone
  module ConesHelper
    def status(key)
      cone = Cone.new(key, {})
      cone.fetch
      cone.measure
    end
  end
end
