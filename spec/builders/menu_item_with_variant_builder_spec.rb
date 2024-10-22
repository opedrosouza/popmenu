require "rails_helper"

RSpec.describe MenuItemWithVariantBuilder, type: :model do
  describe "#build" do
    let(:menu) { create(:menu) }

    let(:params) { { name: "test item", price: 10 } }

    subject { described_class.new(menu: menu, params: params) }

    context "when valid" do
      it "creates a menu_item_variant" do
        expect { subject.build }.to change(MenuItemVariant, :count).by(1)
      end

      it "creates a menu_item" do
        expect { subject.build }.to change(MenuItem, :count).by(1)
      end

      it "associates the menu_item with the menu" do
        subject.build
        item = MenuItem.find_by(name: params[:name])
        expect(menu.menu_items.reload.last).to eq(item)
      end
    end

    context "when the menu item already exists" do
      before do
        create(:menu_item, name: params[:name])
      end

      it "does not create a new menu item" do
        expect { subject.build }.not_to change(MenuItem, :count)
      end

      it "creates a menu item variant" do
        expect { subject.build }.to change(MenuItemVariant, :count).by(1)
      end

      it "associates the menu item with the menu" do
        subject.build
        item = MenuItem.find_by(name: params[:name])
        expect(menu.menu_items.reload.last).to eq(item)
      end
    end

    context "when invalid" do
      let(:params) { { name: nil, price: nil } }

      it "does not create a menu_item_variant" do
        expect { subject.build }.not_to change(MenuItemVariant, :count)
      end

      it "does not create a menu_item" do
        expect { subject.build }.not_to change(MenuItem, :count)
      end

      it "adds an error" do
        subject.build
        expect(subject.errors[:params]).to include("name and price are required")
      end
    end
  end
end
