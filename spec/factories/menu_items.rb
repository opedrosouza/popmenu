# == Schema Information
#
# Table name: menu_items
#
#  id          :integer          not null, primary key
#  description :string
#  name        :string           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
# Indexes
#
#  index_menu_items_on_name  (name) UNIQUE
#
FactoryBot.define do
  factory :menu_item do
    name { "#{Faker::Food.dish} #{SecureRandom.alphanumeric(6)}" }
    description { Faker::Food.description }
  end
end
