# == Schema Information
#
# Table name: menu_items
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string           not null
#  price       :decimal(10, 2)   default(0.0), not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_menu_items_on_name  (name) UNIQUE
#
require "rails_helper"

RSpec.describe MenuItem, type: :model do
  it "has a valid factory" do
    expect(build(:menu_item)).to be_valid
  end

  describe "associations" do
    it { should have_and_belong_to_many(:menus) }
  end

  describe "validations" do
    subject { build(:menu_item) }

    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_presence_of(:price) }
    it { should validate_numericality_of(:price).is_greater_than_or_equal_to(0) }
  end
end
