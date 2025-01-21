class Product < ApplicationRecord
  has_many_attached :images
  belongs_to :size, optional: true
  belongs_to :color, optional: true
  belongs_to :category

  validates :name, presence: true, length: { minimum: 2, maximum: 30 }, format: { with: /\A[a-zA-Z\s\-']+\z/, message: "only allows letters, spaces, hyphens, and apostrophes" }
  validates :description, presence: true, length: { minimum: 4, maximum: 150 }, format: { with: /\A[a-zA-Z\s\-',.]+\z/, message: "only allows letters, spaces, hyphens, apostrophes, commas, and periods" }
  validates :unit_price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :available_stock, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :inventory_entry_date, presence: true

  validates :images, content_type: %w[image/jpeg image/jpg image/png], size: { less_than: 5.megabytes }
  validate :must_have_at_least_one_image

  def self.ransackable_attributes(auth_object = nil)
    [ "name", "description", "category_id" ]
  end

  private

  def must_have_at_least_one_image
    if images.blank?
      errors.add(:images, "must have at least one image")
    end
  end
end
