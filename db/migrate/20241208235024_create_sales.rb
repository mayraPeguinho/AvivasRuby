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
  end
end
