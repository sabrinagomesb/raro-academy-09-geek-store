# frozen_string_literal: true

class SaleProduct < ApplicationRecord
  belongs_to :product
  belongs_to :sale

  validates :amount, numericality: { only_integer: true, is_greater_than_or_equal_to: 1 }

  scope :sold_more_than, ->(amount) { where("amount > ?", amount) }
  scope :sold_less_than, ->(amount) { where("amount < ?", amount) }
  scope :by_amount, ->(amount) { where(amount:) }

  before_save :update_sale_total_price
  before_destroy :update_sale_total_price

  def total_price
    amount * product.unit_price
  end

  def update_sale_total_price
    sale.update_total_price
  end
end
