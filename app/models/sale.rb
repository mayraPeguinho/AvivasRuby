class Sale < ApplicationRecord
  belongs_to :user
  has_many :product_solds, dependent: :destroy

  accepts_nested_attributes_for :product_solds, allow_destroy: true, reject_if: :all_blank

  validates :client, presence: true, length: { minimum: 2, maximum: 30 }, format: { with: /\A[a-zA-Z\s]+\z/, message: "only allows letters and spaces" }
  validates :total_sale, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :realization_datetime, presence: true
  validate :realization_datetime_cannot_be_in_the_future
  validate :must_have_at_least_one_product
  validate :no_duplicate_products

  private

  def realization_datetime_cannot_be_in_the_future
    if realization_datetime.present? && realization_datetime > Time.current
      errors.add(:realization_datetime, "can't be in the future")
    end
  end

  def must_have_at_least_one_product
    if product_solds.empty?
      errors.add(:base, "Sale must have at least one product sold")
    end
  end

  def no_duplicate_products
    product_ids = product_solds.map(&:product_id)
    duplicate_product_ids = product_ids.select { |id| product_ids.count(id) > 1 }.uniq

    # Obtener los nombres de los productos duplicados
    duplicate_product_names = Product.where(id: duplicate_product_ids).pluck(:name)

    if duplicate_product_names.any?
      errors.add(:base, "Each product can only be sold once per sale. Please consolidate the quantities for product(s): #{duplicate_product_names.join(', ')}.")
    end
  end
end

