class RenameDeleteDateToDeletedAtInProducts < ActiveRecord::Migration[8.0]
  def change
    rename_column :products, :delete_date, :deleted_at
  end
end
