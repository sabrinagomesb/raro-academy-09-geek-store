# frozen_string_literal: true

class StoreProduct < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true, is_greater_than_or_equal_to: 0 }
end
