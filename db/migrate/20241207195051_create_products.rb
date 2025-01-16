class CreateProducts < ActiveRecord::Migration[8.0]
  def change
    create_table :products do |t|
      t.string :name, null: false, limit: 30
      t.string :description, null: false, limit: 150
      t.date :inventory_entry_date, null: false
      t.date :delete_date
      t.boolean :is_deleted, null: false, default: false
      t.integer :available_stock, null: false
      t.decimal :unit_price, null: false, precision: 10, scale: 2
      t.references :size, null: true, foreign_key: true
      t.references :color, null: true, foreign_key: true
      t.references :category, null: false, foreign_key: true

      t.timestamps
    end

    add_check_constraint :products, "available_stock >= 0", name: "check_available_stock_positive"
    add_check_constraint :products, "unit_price >= 0", name: "check_unit_price_positive"
    add_check_constraint :products, "delete_date IS NULL OR delete_date > inventory_entry_date", name: "check_valid_delete_date"
  end
end
