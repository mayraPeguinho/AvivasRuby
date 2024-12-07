class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :size
  belongs_to :color
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :available_stock, presence: true
  validates :inventory_entry_date, presence: true
end
