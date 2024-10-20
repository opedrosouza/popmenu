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
      expect(json_body).to eq(serialized(menu.menu_items, MenuItemSerializer))
    end

    it "does not return menu items from other menus" do
      expect(json_body).not_to eq(serialized(other_menu.menu_items, MenuItemSerializer))
    end
  end

  describe "GET /api/menus/:menu_id/menu_items/:id" do
    let(:menu) { create(:menu, :with_menu_item) }
    let(:menu_item) { menu.menu_items.first }

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

  describe "POST /api/menus/:menu_id/menu_items" do
    let(:menu) { create(:menu) }
    let(:menu_item_params) { attributes_for(:menu_item) }

    before do
      post menu_menu_items_path(menu), params: { menu_item: menu_item_params }
    end

    it "returns http created" do
      expect(response).to have_http_status(:created)
    end

    it "creates a new menu item" do
      expect(menu.menu_items.count).to eq(1)
    end

    it "returns the new menu item" do
      expect(json_body).to eq(serialized(menu.menu_items.reload.first, MenuItemSerializer))
    end

    context "when the menu does not exist" do
      before do
        post menu_menu_items_path(menu_id: 0), params: { menu_item: menu_item_params }
      end

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when the menu item is invalid" do
      before do
        post menu_menu_items_path(menu), params: { menu_item: { name: "" } }
      end

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the errors" do
        expect(json_body).to eq({ errors: [ "Name can't be blank" ] })
      end
    end
  end

  describe "PUT /api/menus/:menu_id/menu_items/:id" do
    let(:menu) { create(:menu, :with_menu_item) }
    let(:menu_item) { menu.menu_items.first }
    let(:new_menu_item_params) { attributes_for(:menu_item) }

    before do
      put menu_menu_item_path(menu, menu_item), params: { menu_item: new_menu_item_params }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns the updated menu item" do
      expect(json_body).to eq(serialized(menu_item.reload, MenuItemSerializer))
    end

    it "updates the menu item" do
      expect(menu_item.reload.name).to eq(new_menu_item_params[:name])
    end

    context "when the menu item does not exist" do
      before { put menu_menu_item_path(menu, id: 0) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when the menu item is invalid" do
      before do
        put menu_menu_item_path(menu, menu_item), params: { menu_item: { name: "" } }
      end

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the errors" do
        expect(json_body).to eq({ errors: [ "Name can't be blank" ] })
      end
    end
  end

  describe "DELETE /api/menus/:menu_id/menu_items/:id" do
    let(:menu) { create(:menu, :with_menu_item) }
    let(:menu_item) { menu.menu_items.first }

    before { delete menu_menu_item_path(menu, menu_item) }

    it "returns http no content" do
      expect(response).to have_http_status(:no_content)
    end

    it "deletes the menu item" do
      expect(menu.menu_items.count).to eq(0)
    end

    context "when the menu item does not exist" do
      before { delete menu_menu_item_path(menu, id: 0) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
