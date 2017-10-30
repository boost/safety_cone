require 'spec_helper'

# Specs for SafetyCone::Configuration
module SafetyCone
  describe Configuration do

    context 'Constants' do
      it 'has set valid option keys' do
        expect(SafetyCone::Configuration::VALID_OPTION_KEYS).to eq [:method, :controller,
                                                                             :action, :name]
      end
    end

    context 'adding options' do
      context 'adding a notice to a controller action' do
        before do
          SafetyCone.configure do |config|
            config.add(
              controller: :static_pages,
              action: :home,
              name: 'Home Page'
            )
          end
        end

        it 'Have created a cone entry' do
          expect(SafetyCone.cones).to eq ({ static_pages_home: {
                                                     controller: :static_pages,
                                                     action: :home, name: 'Home Page' }
                                                   })
        end
      end

      context 'Exceptions' do
        it 'will raise an error for name missing' do
          expect { SafetyCone.configure { |config| config.add() } }.to raise_error('Mandatory param :name missing')
        end

        it 'will raise an error if controller and action not passed' do
          expect { SafetyCone.configure { |config| config.add(name: 'Page') } }.to raise_error('Options should contain :controller and :action or :method.')
        end

        it 'will raise an error for invalid measures' do
          expect { SafetyCone.configure { |config| config.add(name: 'Page', action: :posts) } }.to raise_error('Options should contain :controller and :action or :method.')
        end
      end
    end
  end
end
