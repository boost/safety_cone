$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "safety_cone_mountable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "safety_cone_mountable"
  s.version     = SafetyConeMountable::VERSION
  s.authors     = ["Edwin Rozario"]
  s.email       = ["edwin@boost.co.nz"]
  s.homepage    = "https://github.com/boost/safety_cone"
  s.summary     = "Blocks or warns requests."
  s.description = "At times we would want to block certain requests.
                   SafetyCone allows this to be controller from an interface."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "<= 5.0.1"
  s.add_dependency 'redis', '~> 3.3', '>= 3.3.3'

  s.add_development_dependency "sqlite3"
end
