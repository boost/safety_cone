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
          config.add(
            feature: :shopping_cart,
            name: 'Shopping Cart'
          )
          config.auth = { username: 'admin', password: 'password' }
        end

        @paths = SafetyCone.paths
        get :index
      }

      it 'response status 200' do
        expect(response).to have_http_status(200)
      end

      it 'render :index template' do
        expect(response).to render_template :index
      end

      it 'should renter with correct responsed' do
        expect(SafetyCone.paths).to eq(home_index: {
          controller: :home,
          action: :index,
          message: 'This is the flash message with SafetyCone for the home Page',
          name: 'HomePage' })
      end
    end
  end
end
