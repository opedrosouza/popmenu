class RemovePriceFromMenuItem < ActiveRecord::Migration[7.2]
  def change
    remove_column :menu_items, :price, :decimal
  end
end
