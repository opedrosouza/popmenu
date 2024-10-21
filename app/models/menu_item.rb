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
class MenuItem < ApplicationRecord
  has_many :menu_item_variants, inverse_of: :menu_item, dependent: :destroy
  has_many :menus, through: :menu_item_variants

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
