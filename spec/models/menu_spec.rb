# == Schema Information
#
# Table name: menus
#
#  id            :integer          not null, primary key
#  description   :text
#  name          :string           not null
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#  restaurant_id :integer          not null
#
# Indexes
#
#  index_menus_on_restaurant_id  (restaurant_id)
#
# Foreign Keys
#
#  restaurant_id  (restaurant_id => restaurants.id)
#
require "rails_helper"

RSpec.describe Menu, type: :model do
  it "has a valid factory" do
    expect(build(:menu)).to be_valid
  end

  describe "associations" do
    it { should belong_to(:restaurant) }
    it { should have_many(:menu_items).dependent(:destroy) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
