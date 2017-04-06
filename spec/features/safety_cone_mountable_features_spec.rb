require 'rails_helper'
require 'pry'
require 'mock_redis'

describe  'Safety Cone Mountable configuration page' do

  before {
    $redis = MockRedis.new
    $redis.set('safety_cone', 'home_edit')
    SafetyConeMountable.configure do |config|
      config.add(
        controller: :home,
        action: :edit,
        message: 'This is the flash message with SafetyConeMountable for the home Page',
        name: 'HomePage',
        measure: 'notice',
        redis: $redis
      )
      config.redis = $redis
      config.auth = { username: 'admin', password: 'password' }
    end
  }

  scenario 'A user sees the safety cone Configuration page' do
    @cones = SafetyConeMountable.cones

    visit root_path

    within '.offset-s4' do
      expect(page).to have_text('Safety Cone');
    end
  end
end
