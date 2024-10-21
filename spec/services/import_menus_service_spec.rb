require 'rails_helper'

RSpec.describe ImportMenusService, type: :actor do
  let(:import) { create(:import) }
  let(:data) { import.json_read }
  let(:restaurants) { ImportRestaurantsService.call(data:).restaurants }

  subject(:service) { ImportMenusService.call(data: data, restaurants: restaurants) }

  describe '.call' do
    context 'when data is valid' do
      it 'succeeds' do
        expect(service).to be_a_success
      end

      it 'creates menus' do
        expect { service }.to change(Menu, :count).by(data[:restaurants].sum { |r| r[:menus].count })
      end

      it 'returns the menus' do
        expect(service.menus).to eq(Menu.all)
      end
    end

    context 'when menu already exists' do
      before do
        restaurant = create(:restaurant, name: data[:restaurants].first[:name])
        create(:menu, name: data[:restaurants].first[:menus].first[:name], restaurant:)
      end

      it 'succeeds' do
        expect(service).to be_a_success
      end

      it 'does not create the existent menus' do
        expect { service }.to change(Menu, :count).by(data[:restaurants].sum { |r| r[:menus].count } - 1)
      end
    end

    context 'when data is nil' do
      let(:data) { nil }

      it 'raises an error' do
        expect { service }.to raise_error(ServiceActor::ArgumentError)
      end
    end

    context 'when data is empty' do
      let(:data) { {} }

      it 'raises an error' do
        expect { service }.to raise_error(NoMethodError)
      end
    end
  end
end
