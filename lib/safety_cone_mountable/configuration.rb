module SafetyConeMountable
  # Module for configuring safety measures
  module Configuration
    VALID_MEASURES = [
      :block, :warn,
      :notice, :alert
    ].freeze

    VALID_OPTION_KEYS = [
      :method, :controller,
      :action, :name
    ].freeze

    attr_accessor :cones, :options

    # Method add a safety measure
    def add(options = {})
      self.options = options
      valid?
      cones[make_key] = options
    end

    # Method to generate a key from the options
    def make_key
      if options.key? :method
        options[:method].to_sym
      elsif options.include?(:controller) && options.include?(:action)
        "#{options[:controller]}_#{options[:action]}".to_sym
      else
        raise(ArgumentError,
              'Options should contain :controller and :action or :method.')
      end
    end

    # Checks the validity of configuration params
    def valid?
      invalid_options = (options.keys - VALID_OPTION_KEYS)
      unless invalid_options.empty?
        raise ArgumentError, "Options #{invalid_options} are not valid."
      else
        true
      end
    end

    # Configuration method for Rails initializer
    def configure
      self.cones = {}
      yield self
    end
  end
end
