class CreateSizes < ActiveRecord::Migration[8.0]
  def change
    create_table :sizes do |t|
      t.string :name, null: false, limit: 20

      t.timestamps
    end

    add_index :sizes, :name, unique: true

  end
end
