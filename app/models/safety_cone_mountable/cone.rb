module SafetyConeMountable
  class Cone
    attr_accessor :name, :controller, :action,
                  :method, :message, :measure,
                  :key
  
    def initialize(key, params)
      @key = key
      @name = params[:name]
      @controller = params[:controller]
      @method = params[:action]
      @method = params[:method]
      @message = params[:message]
      @method = params[:measure]
    end
  end
end