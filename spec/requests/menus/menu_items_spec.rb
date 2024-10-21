require 'rails_helper'

RSpec.describe "Menus::MenuItemsController", type: :request do
  describe "GET /api/menus/:menu_id/menu_items" do
    let(:menu) { create(:menu, :with_menu_item) }
    let(:other_menu) { create(:menu, :with_menu_item) }

    before do
      get menu_menu_items_path(menu)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of menu items" do
      expect(json_body).to eq(serialized(menu.reload.menu_items, MenuItemSerializer))
    end

    it "does not return menu items from other menus" do
      expect(json_body).not_to eq(serialized(other_menu.reload.menu_items, MenuItemSerializer))
    end
  end

  describe "GET /api/menus/:menu_id/menu_items/:id" do
    let(:menu) { create(:menu, :with_menu_item) }
    let(:menu_item) { menu.reload.menu_items.first }

    before { get menu_menu_item_path(menu, menu_item) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns the menu item with correct data" do
      expect(json_body).to eq(serialized(menu_item, MenuItemSerializer))
    end

    context "when the menu item does not exist" do
      before { get menu_menu_item_path(menu, id: 0) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
