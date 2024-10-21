class ImportMenusService < Actor
  input :data, type: Hash
  input :restaurants, type: Array
  output :menus, type: Array

  def call
    ActiveRecord::Base.transaction do
      self.menus = map_restaurant_object_to_menu_data.flatten.map do |menu|
        Menu.find_or_create_by(menu)
      end
    end
  end

  private

  def map_restaurant_object_to_menu_data
    restaurants.map do |restaurant|
      data[:restaurants].select { |r| r[:name] == restaurant.name }.map do |r|
        r[:menus].map do |menu|
          {
            restaurant_id: restaurant.id,
            name: menu[:name]
          }
        end
      end
    end
  end
end
