require 'rails_helper'
module SafetyConeMountable
  RSpec.describe ConesController, type: :controller do
    # def basic_auth(user, password)
    #   credentials = ActionController::HttpAuthentication::Basic.encode_credentials user, password
    #   request.env['HTTP_AUTHORIZATION'] = credentials
    # end

    describe '#index' do

      it 'the :index template' do
        # credentials = ActionController::HttpAuthentication::Basic.encode_credentials 'admin', 'user'
        # request.env['HTTP_AUTHORIZATION'] = credentials
        get :safety_cone_mountable
        get :cones

      #  expect(response).to render_template :index
      end
    end

  end
end
