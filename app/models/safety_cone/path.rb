module SafetyCone
  class Path
    attr_accessor :name, :controller, :action,
                  :method, :message, :type,
                  :key, :redis

    def initialize(key, params)
      @key = key
      @name = params[:name]
      @controller = params[:controller]
      @method = params[:action]
      @method = params[:method]
      @message = params[:message]
      @type = params[:type] || 'disabled'
      @redis = SafetyCone.redis
    end

    def save
      data = { message: @message, type: @type }.to_json
      @redis.set(redis_key, data)
    end

    def fetch
      stored_data = @redis.get(redis_key)

      if stored_data
        data = JSON.parse(stored_data)
        @message = data['message']
        @type = data['type']
      end
    end

    def redis_key
      "safety::cone::#{@key}"
    end
  end
end
