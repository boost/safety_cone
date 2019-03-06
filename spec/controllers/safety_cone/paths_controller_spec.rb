require 'rails_helper'

module SafetyCone
  RSpec.describe PathsController, type: :controller do

    routes { SafetyCone::Engine.routes }

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

        @paths = SafetyCone.paths

        get :edit, params: { id: 'home_edit' }
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
