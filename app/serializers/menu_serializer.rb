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
class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :menu_items, serializer: MenuItemSerializer
end
