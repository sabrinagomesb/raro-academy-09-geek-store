# frozen_string_literal: true

class Product < ApplicationRecord
  include NameScopes

  has_many :store_products, dependent: :destroy
  has_many :stores, through: :store_products

  has_many :product_suppliers, dependent: :destroy
  has_many :suppliers, through: :product_suppliers

  has_many :sale_products, dependent: :destroy
  has_many :sales, through: :sale_products

  validates :name, :description, :unit_price, presence: true
  validates :unit_price, numericality: { greater_than: 0 }
  validates :name, length: { minimum: 3, maximum: 255 }

  before_validation :round_unit_price

  scope :costs_more_than, ->(amount) { where("unit_price > ?", amount.to_f) }
  scope :costs_less_than, ->(amount) { where("unit_price < ?", amount.to_f) }

  private

  def round_unit_price
    self.unit_price = unit_price.round(2)
  end
end
