module SafetyCone
  module ConesHelper
    def status(key)
      cone = Cone.new(key, {})
      cone.fetch
      cone.type
    end
  end
end
