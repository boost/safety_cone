module SafetyConeMountable
  class Engine < ::Rails::Engine
    isolate_namespace SafetyConeMountable

    initializer "refinery.assets.precompile" do |app|
    app.config.assets.precompile += %w(safety_cone_mountable/logo.png)
  end
  end
end
