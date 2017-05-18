require 'rails_helper'
require 'spec_helper'
require 'pry'

feature  'Edit page' do
  before {
    $redis = MockRedis.new
    $redis.set('safety_cone', 'home_index')

    SafetyConeMountable.configure do |config|
      config.add(
        controller: :home,
        action: :index,
        message: 'This is the flash message with SafetyConeMountable for the home Page',
        name: 'HomePage',
        measure: 'notice',
        redis: $redis,
        keys: '1234'
      )
      config.redis = $redis
      config.auth = { username: 'admin', password: 'password' }
    end
  }

  scenario 'A user sees the safety cone Configuration page header' do
    @cones = SafetyConeMountable.cones
    save_and_open_page

    # visit edit_cone_path(id: 'home_index')

    visit "/safety_cone_mountable/cones/home_index/edit"
    within '.s4' do
      expect(page).to have_text('Safety Cone');
    end
  end

end
