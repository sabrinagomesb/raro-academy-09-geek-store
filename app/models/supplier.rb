# frozen_string_literal: true

class Supplier < ApplicationRecord
  has_many :product_suppliers, dependent: :destroy
  has_many :products, through: :product_suppliers
  has_one :addresses, as: :addressable, dependent: :destroy
end
