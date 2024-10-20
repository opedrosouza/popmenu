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
  has_and_belongs_to_many :menus

  validates :name, presence: true, uniqueness: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
