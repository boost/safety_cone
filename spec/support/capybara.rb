require 'capybara/rails'
require 'capybara/rspec'

Capybara.app = SafetyConeMountable::Engine
Capybara.default_max_wait_time = 2
