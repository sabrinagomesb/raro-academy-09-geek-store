# frozen_string_literal: true

class Store < ApplicationRecord
  has_one :addresses, as: :addressable, dependent: :destroy
  has_many :store_products, dependent: :restrict_with_error
  has_many :products, through: :store_products
  has_many :sales, inverse_of: :store, dependent: :restrict_with_error
end
