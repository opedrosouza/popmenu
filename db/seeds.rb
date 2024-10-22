if Rails.env.local?
  FactoryBot.create_list(:menu_item, 6)
  menu_items = MenuItem.all.sample(3)
  FactoryBot.create_list(:restaurant, 3).each do |restaurant|
    FactoryBot.create_list(:menu, 2, restaurant: restaurant).each do |menu|
      menu_items.each do |menu_item|
        menu.menu_item_variants << FactoryBot.create(:menu_item_variant, menu:, menu_item:)
      end
    end
  end
end
