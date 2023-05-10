# frozen_string_literal: true

class SaleProduct < ApplicationRecord
  belongs_to :product
  belongs_to :sale

  validates :amount, numericality: { only_integer: true, is_greater_than_or_equal_to: 1 }

  scope :sold_more_than, ->(amount) { where("amount > ?", amount) }
  scope :sold_less_than, ->(amount) { where("amount < ?", amount) }
  scope :by_amount, ->(amount) { where(amount:) }
end
