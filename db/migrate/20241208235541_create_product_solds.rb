class CreateProductSolds < ActiveRecord::Migration[8.0]
  def change
    create_table :product_solds do |t|
      t.references :sale, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :amount
      t.decimal :sale_price

      t.timestamps
    end
  end
end
