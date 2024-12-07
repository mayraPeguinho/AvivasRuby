class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.date :inventory_entry_date
      t.date :delete_date
      t.boolean :is_deleted
      t.integer :available_stock
      t.decimal :unit_price
      t.references :size, null: false, foreign_key: true
      t.references :color, null: false, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
