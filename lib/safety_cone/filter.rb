module SafetyCone
  # Module for Filtering requests and raise notices
  # and take measures
  module Filter
    # Method to include to base class.
    # This lets declare a before filter here
    def self.included(base)
      base.before_filter :safety_cone_filter
    end

    # Filter method that does the SafetyCone action
    # based on the configuration.
    def safety_cone_filter
      if cone = fetch_cone
        if cone.type == 'notice'
          flash.now["safetycone_#{notice_type(cone.type)}"] = cone.message
        else
          flash["safetycone_#{notice_type(cone.type)}"] = cone.message
        end

        redirect_to safety_redirect if cone.type == 'block'
      end
    end

    private

    # Fetches a configuration based on current request
    def fetch_cone
      paths = SafetyCone.paths

      if path = paths[request_action]
        key = request_action
      elsif cone = paths[request_method]
        key = request_method
      else
        return false
      end

      path = Path.new(key, path)
      path.fetch

      %w[notice block].include?(path.type) ? path : false
    end

    # Method to redirect a request
    def safety_redirect
      request.env['HTTP_REFERER'] || root_path
    end

    # Returns type of notice
    def notice_type(type)
      type == 'notice' ? 'notice' : 'alert'
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
