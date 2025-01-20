class CreateSales < ActiveRecord::Migration[8.0]
  def change
    create_table :sales do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :total_sale, null:false
      t.string :client, null:false
      t.date :deleted_at
      t.datetime :realization_datetime, null: false

      t.timestamps
    end
    add_check_constraint :sales, "total_sale >= 0", name: "check_total_sale_positive"
  end
end
