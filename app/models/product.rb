# frozen_string_literal: true

class Product < ApplicationRecord
  has_many :store_products, dependent: :destroy
  has_many :stores, through: :store_products

  has_many :product_suppliers, dependent: :destroy
  has_many :suppliers, through: :product_suppliers

  has_many :sale_products, dependent: :destroy
  has_many :sales, through: :sale_products

  validates :name, :description, :unit_price, presence: true
  validates :unit_price, numericality: { greater_than: 0 }
  validates :name, length: { minimum: 3, maximum: 255 }
end
