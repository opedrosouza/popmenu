# == Schema Information
#
# Table name: restaurants
#
#  id         :integer          not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class RestaurantSerializer < ActiveModel::Serializer
  attributes :id, :name

  has_many :menus
end
