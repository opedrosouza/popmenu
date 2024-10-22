require "rails_helper"

RSpec.describe ImportMenuItemsService, type: :actor do
  let(:import) { create(:import) }
  let(:data) { import.json_read }
  let(:restaurants) { ImportRestaurantsService.call(data:).restaurants }
  let(:menus) { ImportMenusService.call(data:, restaurants:).menus }

  subject(:service) { ImportMenuItemsService.call(data: data, menus: menus) }

  describe ".call" do
    context "when data is valid" do
      it "succeeds" do
        expect(service).to be_a_success
      end

      it "creates menu items" do
        expect { service }.to change(MenuItem, :count).by(6)
      end

      it "returns the menu items" do
        expect(service.menu_items_with_variants).to be_an_instance_of(Array)
      end
    end

    context "when menu item already exists" do
      before do
        create(:menu_item, name: data[:restaurants].first[:menus].first[:menu_items].first[:name])
      end

      it "succeeds" do
        expect(service).to be_a_success
      end

      it "does not create the existent menu items" do
        expect { service }.to change(MenuItem, :count).by(5)
      end
    end

    context "when data is nil" do
      let(:data) { nil }

      it "raises an error" do
        expect { service }.to raise_error(ServiceActor::ArgumentError)
      end
    end

    context "when data is empty" do
      let(:data) { {} }

      it "raises an error" do
        expect { service }.to raise_error(NoMethodError)
      end
    end
  end
end
