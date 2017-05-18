require 'rails_helper'

feature  'Edit page' do
  before do
    $redis = MockRedis.new
    $redis.set('safety_cone', 'home_index')

    SafetyConeMountable.configure do |config|
      config.add(
        controller: :home,
        action: :index,
        message: 'This is the flash message with SafetyConeMountable for the home Page',
        name: 'EditPage',
        measure: 'notice',
        redis: $redis,
        keys: '1234'
      )
      config.redis = $redis
      config.auth = { username: 'admin', password: 'password' }
    end
  end

  scenario 'header text' do
    @cones = SafetyConeMountable.cones
    visit root_path

    find('.btn', text: 'edit').click

    within '.s4.center' do
      expect(page).to have_text('Safety Cone');
    end
  end


  scenario 'has edit form' do
    @cones = SafetyConeMountable.cones
    visit root_path

    find('.btn', text: 'edit').click

    within 'form' do
      expect(page).to have_selector('.input-field');
      expect(page).to have_selector('.input-label');
      expect(page).to have_selector('#cone_measure_notice');
      expect(page).to have_selector('#cone_measure_block');
      expect(page).to have_selector('#cone_measure_disabled');
      expect(page).to have_selector('.waves-light.btn');
      expect(page).to have_selector('.waves-light.btn.grey');
    end
  end

end
