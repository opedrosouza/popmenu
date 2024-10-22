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
class MenuItem < ApplicationRecord
  has_many :menu_item_variants, inverse_of: :menu_item, dependent: :destroy
  has_many :menus, through: :menu_item_variants

  validates :name, presence: true, uniqueness: true
end
