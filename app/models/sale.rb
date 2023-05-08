# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :store, inverse_of: :sale
  belongs_to :customer, inverse_of: :sale

  has_many :sale_products, dependent: :restrict_with_error
  has_many :products, through: :sale_products
end
