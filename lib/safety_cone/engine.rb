module SafetyCone
  class Engine < ::Rails::Engine
    isolate_namespace SafetyCone

    initializer 'refinery.assets.precompile' do |app|
      app.config.assets.precompile += %w(safety_cone/logo.png)
    end

    config.generators do |g|
      g.test_framework :rspec, fixture: false
      g.fixture_replacement :factory_girl, dir: 'spec/factories'
      g.assets false
      g.helper false
    end
  end
end
