module SafetyConeMountable
  module ConesHelper
    def active(key)
      cone = Cone.new(key, {})
      cone.fetch
      ['notice', 'block'].include?(cone.measure) 
    end
  end
end
