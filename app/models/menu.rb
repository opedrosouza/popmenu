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
class Menu < ApplicationRecord
  belongs_to :restaurant, inverse_of: :menus
  has_many :menu_item_variants, inverse_of: :menu, dependent: :destroy
  has_many :menu_items, through: :menu_item_variants

  validates :name, presence: true
end
