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
    let(:flash) { ActionDispatch::Flash::FlashHash.new }

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
      controller_instance.stub(:flash) { flash }

      allow(redis).to receive(:get) { { message: 'foo', type: 'notice' }.to_json }
    end

    # This requires a lot more improvements
    context 'Request to home page' do
      it 'fetches all the paths' do
        allow(SafetyCone).to receive(:paths) { { static_pages_home: {
                                                     controller: :static_pages,
                                                     action: :home, name: 'Home Page' }
                                                   } }

        expect(SafetyCone).to receive(:paths)

        controller_instance.send(:fetch_cone)
      end

      it 'sets flash notice' do
        allow(SafetyCone).to receive(:paths) { { static_pages_home: {
                                                     controller: :static_pages,
                                                     action: :home, name: 'Home Page' }
                                                   } }

        expect(flash).to receive(:[]).with('safetycone_notice')

        controller_instance.send(:safety_cone_filter)
      end
    end
  end
end
