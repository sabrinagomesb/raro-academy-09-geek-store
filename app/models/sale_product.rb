# frozen_string_literal: true

class SaleProduct < ApplicationRecord
  belongs_to :product
  belongs_to :sale

  validates :amount, numericality: { only_integer: true, is_greater_than_or_equal_to: 1 }
end
