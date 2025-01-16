class CreateColors < ActiveRecord::Migration[8.0]
  def change
    create_table :colors do |t|
      t.string :name, null: false, limit: 20

      t.timestamps
    end

    add_index :colors, :name, unique: true

  end
end
