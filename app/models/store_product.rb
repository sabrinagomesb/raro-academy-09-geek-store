# frozen_string_literal: true

class StoreProduct < ApplicationRecord
  belongs_to :product
  belongs_to :store

  validates :amount, presence: true
  validates :amount, numericality: { only_integer: true, is_greater_than_or_equal_to: 0 }

  scope :with_stock_amount, ->(amount) { where(amount:) }
  scope :in_stock, -> { where("amount > ?", 0) }
  scope :out_of_stock, -> { where(amount: 0) }
  scope :by_store, ->(store_id) { where(store_id:) }
  scope :by_product, ->(product_id) { where(product_id:) }

  def product_available?(amount)
    amount.positive? && amount <= self.amount
  end

  def decrease_amount(amount)
    self.amount -= amount if amount <= self.amount
    save
  end

  def increase_amount(amount)
    self.amount += amount if amount.positive?
    save
  end

  def self.increase_amount(store_id, product_id, amount)
    store_product = find_by(store_id:, product_id:)
    store_product.increase_amount(amount)
  end

  def self.decrease_amount(store_id, product_id, amount)
    store_product = find_by(store_id:, product_id:)
    store_product.decrease_amount(amount)
  end
end
