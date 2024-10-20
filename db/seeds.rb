if Rails.env.local?
  FactoryBot.create_list(:menu_item, 6)

  FactoryBot.create_list(:restaurant, 3).each do |restaurant|
    FactoryBot.create_list(:menu, 2, restaurant: restaurant).each do |menu|
      menu.menu_items << MenuItem.all.sample(3)
    end
  end
end
