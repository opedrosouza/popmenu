class MenuItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :price

  belongs_to :menu, serializer: MenuSerializer

  def price
    object.price.to_f
  end
end
