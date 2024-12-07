json.extract! product, :id, :name, :description, :inventory_entry_date, :delete_date, :is_deleted, :available_stock, :unit_price, :size_id, :color_id, :category_id, :created_at, :updated_at
json.url product_url(product, format: :json)
