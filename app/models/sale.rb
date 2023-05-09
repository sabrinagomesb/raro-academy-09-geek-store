# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :store
  belongs_to :customer

  has_many :sale_products, dependent: :destroy
  has_many :products, through: :sale_products
end
