# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :store_products, dependent: :restrict_with_error
  has_many :stores, through: :store_products

  has_many :product_suppliers, dependent: :restrict_with_error
  has_many :suppliers, through: :product_suppliers

  has_many :sale_products, dependent: :restrict_with_error
  has_many :sales, through: :sale_products
end
