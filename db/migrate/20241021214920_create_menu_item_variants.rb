class CreateMenuItemVariants < ActiveRecord::Migration[7.2]
  def change
    create_table :menu_item_variants do |t|
      t.decimal :price, precision: 10, scale: 2, null: false
      t.references :menu_item, null: false, foreign_key: true
      t.references :menu, null: false, foreign_key: true

      t.timestamps
    end
  end
end
