require 'rails_helper'
require 'spec_helper'
require 'pry'
require 'mock_redis'

feature  'Home page' do
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
        redis: $redis
      )
      config.redis = $redis
      config.auth = { username: 'admin', password: 'password' }
    end
  }

  scenario 'A user sees the safety cone Configuration page header' do
    @cones = SafetyConeMountable.cones
    visit root_path
    within '.s4' do
      expect(page).to have_text('Safety Cone');
    end
  end

  scenario 'A user sees the safety cone Configuration page header' do
    @cones = SafetyConeMountable.cones
    visit root_path
    within '.s6.offset-s3' do
      expect(page).to have_selector('.waves-light.btn')
      expect(page).to have_text('HomePage');
      expect(page).to have_text('edit');

       find('.btn', text: 'edit').click
      # expect(page).to have_selector('.input-field');
      #response.should render_template('home_index/edit')
    end
  end

end
