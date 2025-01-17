class CreateProductSolds < ActiveRecord::Migration[8.0]
  def change
    create_table :product_solds do |t|
      t.references :sale, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :amount, null: false
      t.decimal :sale_price, null: false

      t.timestamps
    end
  end
end
