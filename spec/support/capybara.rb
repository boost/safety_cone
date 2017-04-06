# spec/support/capybara.rb
require 'capybara/rspec'
require 'capybara/rails'

Capybara.app = SafetyConeMountable::Engine

RSpec.configure do |config|
  config.include SafetyConeMountable::Engine.routes.url_helpers
end
