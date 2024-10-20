require 'rails_helper'

RSpec.describe "MenuItemsController", type: :request do
  describe "GET /api/menu_items" do
    before do
      create_list(:menu_item, 3)
      get menu_items_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of menu items" do
      expect(json_body).to eq(serialized(MenuItem.all, MenuItemSerializer))
    end
  end

  describe "GET /api/menu_items/:id" do
    let(:menu_item) { create(:menu_item) }

    before { get menu_item_path(menu_item) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns the menu item with correct data" do
      expect(json_body).to eq(serialized(menu_item, MenuItemSerializer))
    end

    context "when the menu item does not exist" do
      before { get menu_item_path(id: 0) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
