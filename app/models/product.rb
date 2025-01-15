class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :size, optional: true
  belongs_to :color, optional: true
  belongs_to :category

  validates :name, presence: true
  validates :description, presence: true
  validates :unit_price, presence: true
  validates :available_stock, presence: true
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
    if images.blank? && !images.attached?
      errors.add(:images, "must have at least one image")
    end
  end
end
