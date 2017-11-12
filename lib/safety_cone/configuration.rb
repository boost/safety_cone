module SafetyCone
  # Module for configuring safety measures
  module Configuration
    VALID_OPTION_KEYS = %i[method controller action name].freeze

    attr_accessor :options, :redis, :auth, :paths, :features

    # Method add a route or method to be managed by safety cone
    def add(options = {})
      self.options = options

      raise(ArgumentError, 'Mandatory param :name missing') unless options[:name]

      if options[:feature]
        features << options
        SafetyCone::ViewHelpers.add_method(options[:feature])
      else
        paths[make_key] = options
      end
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

    # Configuration method for Rails initializer
    def configure
      self.paths = {}
      self.features = []
      self.auth = { username: nil, password: nil }

      yield self
    end
  end
end
