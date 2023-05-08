# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_many :product_suppliers, dependent: :restrict_with_error
  has_many :products, through: :product_suppliers
end
