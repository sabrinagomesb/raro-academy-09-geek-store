# frozen_string_literal: true

class Product < ApplicationRecord
  include ModelsValidators

  has_many :store_products, dependent: :destroy
  has_many :stores, through: :store_products

  has_many :product_suppliers, dependent: :destroy
  has_many :suppliers, through: :product_suppliers

  has_many :sale_products, dependent: :destroy
  has_many :sales, through: :sale_products

  validates :name, :description, presence: true
  validates :total_price, numericality: { is_greater_than_or_equal_to: 0 }
  validate :name_allowed_length
end
