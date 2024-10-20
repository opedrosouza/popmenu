class CreateMenuItemsMenus < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_items_menus, id: false do |t|
      t.references :menu_item, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true
      t.timestamps
    end
  end
end
