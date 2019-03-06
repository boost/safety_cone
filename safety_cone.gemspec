$:.push File.expand_path('../lib', __FILE__)

# Maintain your gem's version:
require 'safety_cone/version'

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = 'safety_cone'
  s.version     = SafetyCone::VERSION

  s.authors     = ['Boost', 'Edwin Rozario', 'Gustavo Kazuo Motizuki', 'yhtut']
  s.email       = ['info@boost.co.nz']
  s.homepage    = 'https://github.com/boost/safety_cone'
  s.summary     = 'Blocks or warns requests as cofigured by the admin'
  s.description = 'At times we would want to block certain requests.
                   SafetyCone allows this to be controlled from an interface.
                   It also provides a feature flipper for the views.'
  s.license     = 'MIT'

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.md']

  s.add_dependency 'rails', '<= 5.2.2'
  s.add_dependency 'redis', '~> 3.3', '>= 3.3.3'

  s.add_development_dependency 'sqlite3', '1.3.13'
  s.add_development_dependency 'capybara', '2.14.0'
  s.add_development_dependency 'factory_bot_rails', '~> 5.0', '>= 5.0.1'
  s.add_development_dependency 'database_cleaner', '1.6.1'
  s.add_development_dependency 'pry', '0.10.4'
  s.add_development_dependency 'rspec-rails', '3.8.2'
  s.add_development_dependency 'rails-controller-testing', '1.0.2'
  s.add_development_dependency 'mock_redis', '~> 0.17.3'
  s.add_development_dependency 'launchy', '2.4.3'
end
