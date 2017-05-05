module SafetyConeMountable
  class Cone
    attr_accessor :name, :controller, :action,
                  :method, :message, :measure,
                  :key, :redis

    def initialize(key, params)
      @key = key
      @name = params[:name]
      @controller = params[:controller]
      @method = params[:action]
      @method = params[:method]
      @message = params[:message]
      @measure = params[:measure] || 'disabled'
      @redis = SafetyConeMountable.redis
    end

    def save
      data = { message: @message, measure: @measure }.to_json
      @redis.set(redis_key, data)
    end

    def fetch
      stored_data = @redis.get(redis_key)

      if stored_data
        data = JSON.parse(stored_data)
        @message = data['message']
        @measure = data['measure']
      end
    end

    def redis_key
      "safety::cone::#{@key}"
    end
  end
end
