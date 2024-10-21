# == Schema Information
#
# Table name: menu_item_variants
#
#  id           :integer          not null, primary key
#  price        :decimal(, )
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  menu_id      :integer          not null
#  menu_item_id :integer          not null
#
# Indexes
#
#  index_menu_item_variants_on_menu_id       (menu_id)
#  index_menu_item_variants_on_menu_item_id  (menu_item_id)
#
# Foreign Keys
#
#  menu_id       (menu_id => menus.id)
#  menu_item_id  (menu_item_id => menu_items.id)
#
require 'rails_helper'

RSpec.describe MenuItemVariant, type: :model do
  it "has a valid factory" do
    expect(build(:menu_item_variant)).to be_valid
  end

  describe "associations" do
    it { should belong_to(:menu_item) }
    it { should belong_to(:menu) }
  end

  describe "validations" do
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
