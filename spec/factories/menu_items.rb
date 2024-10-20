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
#  menu_id     :integer          not null
#
# Indexes
#
#  index_menu_items_on_menu_id  (menu_id)
#  index_menu_items_on_name     (name) UNIQUE
#
# Foreign Keys
#
#  menu_id  (menu_id => menus.id)
#
FactoryBot.define do
  factory :menu_item do
    name { "#{Faker::Food.dish} #{SecureRandom.alphanumeric(6)}" }
    description { Faker::Food.description }
    price { Faker::Number.decimal }
    menu
  end
end
