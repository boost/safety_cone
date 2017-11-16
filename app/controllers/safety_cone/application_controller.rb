module SafetyCone
  class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception

    unless Rails.env.test?
      http_basic_authenticate_with name: SafetyCone.auth[:username],
        password: SafetyCone.auth[:password] if (SafetyCone.auth[:username] && SafetyCone.auth[:password])
    end
  end
end
