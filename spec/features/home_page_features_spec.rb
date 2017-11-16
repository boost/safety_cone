require 'rails_helper'

feature 'Home page' do
  background do
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
  end

  scenario 'header text' do
    @paths = SafetyCone.paths
    visit root_path
    within '.header' do
      expect(page).to have_text('Safety Cone')
    end

    expect(page).to have_text('Requests')
    expect(page).to have_text('Features')
  end

  scenario 'page have all the element' do
    @paths = SafetyCone.paths
    visit root_path

    expect(page).to have_selector('.waves-light.btn')
    expect(page).to have_text('HomePage')
    expect(page).to have_text('edit')
  end
end
