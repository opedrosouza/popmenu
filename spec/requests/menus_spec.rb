require 'rails_helper'

RSpec.describe "MenusController", type: :request do
  describe "GET /api/menus" do
    before do
      create_list(:menu, 3)
      get menus_path
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns a list of menus with correct data" do
      expect(json_body).to eq(serialized(Menu.all, MenuSerializer))
    end
  end

  describe "GET /api/menus/:id" do
    let(:menu) { create(:menu) }

    before do
      get menu_path(menu)
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns the menu with correct data" do
      expect(json_body).to eq(serialized(menu, MenuSerializer))
    end

    context "when the menu does not exist" do
      before { get menu_path(id: 0) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end

  describe "POST /api/menus" do
    let(:restaurant) { create(:restaurant) }
    let(:menu_params) { attributes_for(:menu).merge(restaurant_id: restaurant.id) }

    before do
      post menus_path, params: { menu: menu_params }
    end

    it "returns http created" do
      expect(response).to have_http_status(:created)
    end

    it "creates a new menu" do
      expect(Menu.count).to eq(1)
    end

    it "returns the new menu with correct data" do
      expect(json_body).to eq(serialized(Menu.first, MenuSerializer))
    end

    context "when the menu is invalid" do
      let(:menu_params) { attributes_for(:menu, name: nil).merge(restaurant_id: restaurant.id) }

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the errors" do
        expect(json_body).to eq(errors: [ "Name can't be blank" ])
      end
    end
  end

  describe "PUT /api/menus/:id" do
    let(:menu) { create(:menu) }
    let(:menu_params) { { name: "testmenu", description: "testdescription" } }

    before do
      put menu_path(menu), params: { menu: menu_params }
    end

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "returns the updated menu with correct data" do
      menu.reload
      expect(json_body).to eq(serialized(menu, MenuSerializer))
    end

    it "updates the menu" do
      menu.reload
      aggregate_failures do
        expect(menu.name).to eq("testmenu")
        expect(menu.description).to eq("testdescription")
      end
    end

    context "when the menu does not exist" do
      before { put menu_path(id: 0) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end

    context "when the menu is invalid" do
      let(:menu_params) { attributes_for(:menu, name: nil) }

      it "returns http unprocessable entity" do
        expect(response).to have_http_status(:unprocessable_entity)
      end

      it "returns the errors" do
        expect(json_body).to eq(errors: [ "Name can't be blank" ])
      end
    end
  end

  describe "DELETE /api/menus/:id" do
    let!(:menu) { create(:menu) }

    before { delete menu_path(menu) }

    it "returns http success" do
      expect(response).to have_http_status(:success)
    end

    it "deletes the menu" do
      expect(Menu.count).to eq(0)
    end

    context "when the menu does not exist" do
      before { delete menu_path(id: 0) }

      it "returns http not found" do
        expect(response).to have_http_status(:not_found)
      end
    end
  end
end
