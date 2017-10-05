module SafetyCone
  # Module for Filtering requests and raise notices
  # and take measures
  module Filter
    # Method to include to base class.
    # This lets declare a before filter here
    def self.included(base)
      base.before_action :safety_cone_filter
    end

    # Filter method that does the SafetyCone action
    # based on the configuration.
    def safety_cone_filter
      cone = fetch_cone
      return unless cone
 
      flash.clear
      flash[notice_type(cone.measure)] = cone.message
      redirect_to safety_redirect if cone.measure == 'block'
    end

    # Fetches a configuration based on current request
    def fetch_cone
      cones = SafetyCone.cones

      if cone = cones[request_action]
        key = request_action
      elsif cone = cones[request_method]
        key = request_method
      else
        return false
      end

      cone = Cone.new(key, cone)
      cone.fetch
      
      %w[notice block].include?(cone.measure) ? cone : false
    end

    # Method to redirect a request
    # Redirected to the last page by default
    # If there is no HTTP_REFERER its redirected to root
    def safety_redirect
      request.env['HTTP_REFERER'] || root_path
    end

    # Returns type of notice
    def notice_type(measure)
      measure == 'notice' ? 'notice' : 'alert'
    end

    # Returns the current request action as a symbol
    def request_method
      request.method.to_sym
    end

    # Returns the current controller_action as a symbol
    def request_action
      "#{controller_name}_#{action_name}".to_sym
    end
  end
end
