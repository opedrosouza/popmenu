# == Schema Information
#
# Table name: menu_item_variants
#
#  id           :integer          not null, primary key
#  price        :decimal(10, 2)   not null
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
FactoryBot.define do
  factory :menu_item_variant do
    price { Faker::Number.decimal }
    menu_item
    menu
  end
end
