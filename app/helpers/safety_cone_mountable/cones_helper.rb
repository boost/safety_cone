module SafetyConeMountable
  module ConesHelper
    def status(key)
      cone = Cone.new(key, {})
      cone.fetch
      measure = cone.measure
      measure == 'disable' ? 'disabled' : measure
    end
  end
end
