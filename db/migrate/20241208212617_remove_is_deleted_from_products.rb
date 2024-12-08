class RemoveIsDeletedFromProducts < ActiveRecord::Migration[8.0]
  def change
    remove_column :products, :is_deleted, :boolean
  end
end
