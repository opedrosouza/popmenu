class ImportMenuItemsService < Actor
  input :data, type: Hash
  input :menus, type: Array
  output :menu_items_with_variants, type: Array

  def call
    ActiveRecord::Base.transaction do
      self.menu_items_with_variants = all_menu_items_from_data.map do |menu_item|
        builder = MenuItemWithVariantBuilder.new(menu: menu_item[:menu], params: { name: menu_item[:name], price: menu_item[:price] })
        builder.build
      end
    end
  end

  private

  def all_menu_items_from_data
    data[:restaurants].map do |restaurant|
      restaurant[:menus].map do |menu|
        items = menu[:menu_items] || menu[:dishes]
        items.map do |item|
          {
            menu: menus.find { |m| m.name == menu[:name] },
            name: item[:name],
            price: item[:price]
          }
        end
      end
    end.flatten
  end
end
