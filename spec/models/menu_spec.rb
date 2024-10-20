# == Schema Information
#
# Table name: menus
#
#  id          :integer          not null, primary key
#  description :text
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
require 'rails_helper'

RSpec.describe Menu, type: :model do
  it 'has a valid factory' do
    expect(build(:menu)).to be_valid
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end
end
