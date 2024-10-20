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
class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :menu_items

  belongs_to :restaurant

  def menu_items
    ActiveModel::SerializableResource.new(object.menu_items, each_serializer: MenuItemSerializer).serializable_hash
  end
end
