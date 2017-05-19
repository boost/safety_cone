require 'spec_helper'

class ControllerClass < ActionController::Base
  include SafetyCone::Filter
end

class RedisMock 
  def get(key); end
end

# Specs for SafetyCone::Configuration
module SafetyCone
  describe Filter do
    let(:redis) { RedisMock.new }
    let(:controller_instance) { ControllerClass.new }

    before do
      SafetyCone.configure do |config|
        config.redis = redis

        config.add(
          controller: :static_pages,
          action: :home,
          name: 'Home Page'
        )
      end

      controller_instance.stub(:controller_name) { 'static_pages' }
      controller_instance.stub(:action_name) { 'home' }
      allow(redis).to receive(:get) { { message: 'foo', measure: 'quxx' }.to_json }
    end

    # This requires a lot more improvements
    context 'Request to home page' do
      it 'fetches all the cones' do
        allow(SafetyCone).to receive(:cones) { { static_pages_home: { 
                                                     controller: :static_pages, 
                                                     action: :home, name: 'Home Page' } 
                                                   } }

        expect(SafetyCone).to receive(:cones)

        controller_instance.fetch_cone
      end
    end

  end
end
