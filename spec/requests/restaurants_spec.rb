require 'rails_helper'

RSpec.describe "Restaurants", type: :request do
  describe "GET /api/restaurants" do
    let(:restaurants) { create_list(:restaurant, 3) }

    before { get restaurants_path }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of restaurants with correct data" do
      expect(json_body).to eq(serialized(Restaurant.all, RestaurantSerializer))
    end
  end

  describe "GET /api/restaurants/:id" do
    let(:restaurant) { create(:restaurant) }

    before { get restaurant_path(restaurant) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns the restaurant with correct data" do
      expect(json_body).to eq(serialized(restaurant, RestaurantSerializer))
    end

    context "when the restaurant does not exist" do
      before { get restaurant_path(id: 0) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
