require 'rails_helper'

feature  'Home page' do
  background {
    $redis = MockRedis.new
    $redis.set('safety_cone', 'home_index')

    SafetyCone.configure do |config|
      config.add(
        controller: :home,
        action: :index,
        message: 'This is the flash message with SafetyCone for the home Page',
        name: 'HomePage',
        type: 'notice',
        redis: $redis
      )
      config.redis = $redis
      config.auth = { username: 'admin', password: 'password' }
    end
  }

  scenario 'header text' do
    @cones = SafetyCone.cones
    visit root_path
    within '.s4' do
      expect(page).to have_text('Safety Cone');
    end
  end

  scenario 'page have all the element' do
    @cones = SafetyCone.cones
    visit root_path

    within '.s6.offset-s3' do
      expect(page).to have_selector('.waves-light.btn')
      expect(page).to have_text('HomePage');
      expect(page).to have_text('edit');
    end
  end

end
