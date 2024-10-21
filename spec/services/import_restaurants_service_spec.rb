require 'rails_helper'

RSpec.describe ImportRestaurantsService, type: :actor do
  let(:data) { create(:import).json_read }

  subject(:service) { described_class.call(data: data) }

  describe '.call' do
    context 'when data is valid' do
      it 'succeeds' do
        expect(service).to be_a_success
      end

      it 'creates the restaurants' do
        expect { service }.to change(Restaurant, :count).by(data[:restaurants].count)
      end

      it 'returns the restaurants' do
        expect(service.restaurants).to eq(Restaurant.all)
      end
    end

    context 'when restaurant already exists' do
      before { create(:restaurant, name: data[:restaurants].first[:name]) }

      it 'succeeds' do
        expect(service).to be_a_success
      end

      it 'does not create the existent restaurants' do
        expect { service }.to change(Restaurant, :count).by(data[:restaurants].count - 1)
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
