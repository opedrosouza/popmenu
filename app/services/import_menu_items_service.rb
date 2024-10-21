class ImportMenuItemsService < Actor
  input :data, type: Hash
  input :menus, type: Array

  def call
    ActiveRecord::Base.transaction do
      all_menu_items_from_data
    end
  end

  private

  def all_menu_items_from_data
    data[:restaurants].map do |restaurant|
      restaurant[:menus].map do |menu|
        items = menu[:menu_items] || menu[:dishes]
        items.map do |item|
          {
            restaurant: restaurant[:name],
            name: item[:name],
            price: item[:price]
          }
        end
      end
    end.flatten
  end
end
