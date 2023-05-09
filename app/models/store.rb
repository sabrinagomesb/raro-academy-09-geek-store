# frozen_string_literal: true

class Store < ApplicationRecord
  has_many :store_products, dependent: :destroy
  has_many :products, through: :store_products
  has_many :sales, inverse_of: :store, dependent: :destroy
  has_one :addresses, as: :addressable, dependent: :destroy
end
