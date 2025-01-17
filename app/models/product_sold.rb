class ProductSold < ApplicationRecord
  belongs_to :sale
  belongs_to :product

  validates :amount, presence: true, numericality: {  only_integer: true, greater_than_or_equal_to: 0 }
  validates :sale_price, presence: true, numericality: {greater_than_or_equal_to: 0 }
  
  validate :stock_sufficient?

  before_save :set_sale_price

  private


  def set_sale_price
    self.sale_price ||= self.product.unit_price if self.product
  end

  def stock_sufficient?
    if amount.present? && product.present?
      if product.available_stock < amount
        errors.add(:amount, "is greater than available stock")
      end
    end
  end
end

