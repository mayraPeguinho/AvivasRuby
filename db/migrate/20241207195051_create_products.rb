class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false
      t.string :description, null: false
      t.date :inventory_entry_date, null: false
      t.date :delete_date
      t.boolean :is_deleted, null: false, default: false
      t.integer :available_stock, null: false
      t.decimal :unit_price, null: false
      t.references :size, null: true, foreign_key: true
      t.references :color, null: true, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
