# == Schema Information
#
# Table name: imports
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'rails_helper'

RSpec.describe Import, type: :model do
  it "has a valid factory" do
    expect(build(:import)).to be_valid
  end

  describe "associations" do
    it { should have_one_attached(:file) }
  end

  describe "validations" do
    it { should validate_presence_of(:file) }

    it "validates the correct file mime type" do
      import = build(:import)
      expect(import).to be_valid

      import = build(:import, file: fixture_file_upload('restaurant_data.csv', 'application/csv'))
      expect(import).to_not be_valid
    end
  end
end
