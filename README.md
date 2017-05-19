# SafetyCone

Safety Cone is a Rails gem that lets an application to temporarily warn/block requests to pages in case of maintenance. Safety Cone allows the application raise warnings or custom messages managed from an interface.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'safety_cone'
```

And then execute:
```bash
$ bundle
```

## Usage

Create a safety_con.rb file in config/initializer/. The routes that needs to be managed can be added to this config file.

```
$redis = Redis::Namespace.new("app_name", :redis => Redis.new)

SafetyConeMountable.configure do |config|
  # REdis connection for safety_cone
  config.redis = $redis

  # Http auth username and password for safetcone admin page
  config.auth = { username: 'admin', password: 'admin-password' }

  # Added controller action to safety cone
  config.add(
    controller: :registrations,
    action: :new,
    name: 'User Registration'
  )

  # Added controller action to safety cone
  config.add(
    controller: :records,
    action: :create,
    name: 'Record Creation'
  )  
end
```

In routes add

```
  mount SafetyConeMountable::Engine, :at => '/safety_cone'
```

In ApplicationController

```
class ApplicationController < ActionController::Base
  protect_from_forgery

  # Add this line
  include SafetyCone::Filter
end
```

Now you should be able to got to http://localhost:3000/safety_cone and manage your routes.


SafetyCone uses flash messages. So its expected that flash messages are rendered on all views.

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
