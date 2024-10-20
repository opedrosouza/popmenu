class MenuSerializer < ActiveModel::Serializer
  attributes :id, :name, :description

  has_many :menu_items, serializer: MenuItemSerializer
end
