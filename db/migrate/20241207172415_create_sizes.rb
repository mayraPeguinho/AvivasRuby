class CreateSizes < ActiveRecord::Migration[8.0]
  def change
    create_table :sizes do |t|
      t.string :name, null: false

      t.timestamps
    end
  end
end
