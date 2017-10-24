require 'rails_helper'

module SafetyCone
  RSpec.describe ConesController, type: :controller do

    routes { SafetyCone::Engine.routes }
    describe '#index' do
      before {
        SafetyCone.configure do |config|
          config.add(
            controller: :home,
            action: :index,
            message: 'This is the flash message with SafetyCone for the home Page',
            name: 'HomePage',
          )
          config.auth = { username: 'admin', password: 'password' }
        end
        @cones = SafetyCone.cones
        get :index
      }

      it 'response status 200' do
        expect(response).to have_http_status(200)
      end

      it 'render :index template' do
        expect(response).to render_template :index
      end

      it 'should renter with correct responsed' do
        expect(SafetyCone.cones).to eq( { home_index: {
          controller: :home,
          action: :index,
          message: 'This is the flash message with SafetyCone for the home Page',
          name: 'HomePage'} })
      end
    end

    describe '#edit' do
      before {
        $redis = MockRedis.new
        $redis.set('safety_cone', 'home_edit')
        SafetyCone.configure do |config|
          config.add(
            controller: :home,
            action: :edit,
            message: 'This is the flash message with SafetyCone for the home Page',
            name: 'editPage',
            type: 'notice',
            redis: $redis,
            keys: '1234'
          )
          config.redis = $redis
          config.auth = { username: 'admin', password: 'password' }
        end
        @cones = SafetyCone.cones
        get :edit, { id: 'home_edit' }
      }

      it 'response status 200' do
        expect(response).to have_http_status(200)
      end

      it 'render :edit template' do
        expect(response).to render_template :edit
      end
    end
  end
end
