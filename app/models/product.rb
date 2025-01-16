class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :size, optional: true
  belongs_to :color, optional: true
  belongs_to :category

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }
  validates :description, presence: true, length: {  minimum: 4, maximum: 150 }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :available_stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :inventory_entry_date, presence: true

  validate :must_have_at_least_one_image, on: [:create, :update]

  def resized_images(width, height)
    images.map do |image|
      image.variant(resize_to_fill: [width, height]).processed
    end
  end

  def self.ransackable_attributes(auth_object = nil)
    ["name", "description", "category_id"]
  end

  private

  def must_have_at_least_one_image
    errors.add(:images, "must have at least one image") if images.blank?
  end
end
