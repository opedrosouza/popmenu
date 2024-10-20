# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require "rails_helper"

RSpec.describe Restaurant, type: :model do
  it "has a valid factory" do
    expect(build(:restaurant)).to be_valid
  end

  describe "associations" do
    it { should have_many(:menus) }
  end

  describe "validations" do
    it { should validate_presence_of(:name) }
  end
end
