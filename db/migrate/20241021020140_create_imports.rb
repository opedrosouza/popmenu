class CreateImports < ActiveRecord::Migration[7.2]
  def change
    create_table :imports do |t|
      t.timestamps
    end
  end
end
