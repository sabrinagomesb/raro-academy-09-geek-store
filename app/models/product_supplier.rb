# frozen_string_literal: true

class ProductSupplier < ApplicationRecord
  belongs_to :product
  belongs_to :supplier

  scope :for_product, ->(product_id) { where(product_id: product_id) }
  scope :for_supplier, ->(supplier_id) { where(supplier_id: supplier_id) }
end
