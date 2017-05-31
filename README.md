![safety cone logo](https://raw.githubusercontent.com/boost/safety_cone/master/app/assets/images/safety_cone/logo.png)
#  SafetyCone

Safety Cone is a Rails gem that allows you to temporarily add warnings or block requests to specific pages through a simple interface. It's intended use case is primarily for maintenance.

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

Create a safety_cone.rb file in config/initializers. The routes that needs to be managed can be added to this config file.

```
$redis = Redis::Namespace.new("app_name", :redis => Redis.new)

SafetyCone.configure do |config|
  # Redis connection for safety_cone
  config.redis = $redis

  # Http auth username and password for Safety Cone admin page
  config.auth = { username: 'admin', password: 'admin-password' }

  # To allow Safety Cone to manage a single controller action
  config.add(
    controller: :registrations,
    action: :new,
    name: 'User Registration'
  )

  # To allow Safety Cone to manage all POST requests
  config.add(
    method: 'POST',
    name: 'All POST requests'
  )
end
```

In routes add

```
  mount SafetyCone::Engine, :at => '/safety_cone'
```

In ApplicationController

```
class ApplicationController < ActionController::Base
  protect_from_forgery

  # Add this line
  include SafetyCone::Filter
end
```

Now you should be able to go to http://localhost:3000/safety_cone and manage your routes.


SafetyCone uses flash messages. It is expected that flash messages are rendered on all views.


## For version 0.1.0 users

This earlier version is not a mountable engine and it does not provide an admin interface. The configuration is as follows:

```
SafetyCone.configure do |config|
  # disables Safety Cone. By default this value is true
  config.enabled = false

  # This config will block all POST requests and display this message.
  config.add(
    method: :POST,
    message: 'We are unable to write any data to database now.',
    measure: :block
  )

  # This is a controller action specific warning. But with no measures to prevent this action
  config.add(
    controller: :users,
    action: :new,
    message: 'We are unable to register any user now. Please try after sometime.'
    measure: :notice
  )

  # This is a controller action specific block. This config will let the application
  # to raise an alert message and block the request from hitting the controller action.
  config.add(
    controller: 'users',
    action: 'create',
    message: 'We are unable to register any user now. Please try after sometime.',
    measure: :block
  )

  # This is a controller action specific block with a redirect configured.
  config.add(
    controller: 'users',
    action: 'create',
    message: 'We are unable to register any user now. Please try after sometime.',
    measure: :block,
    redirect: '/page/more_info'
  )

  # For :block flash message is an alert
  # For :notice flash message is a notice
end
```


## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
