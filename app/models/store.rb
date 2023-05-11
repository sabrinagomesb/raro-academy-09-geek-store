# frozen_string_literal: true

class Store < ApplicationRecord
  include NameScopes

  has_many :store_products, dependent: :destroy
  has_many :products, through: :store_products
  has_many :sales, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy

  validates :name, :cnpj, presence: true
  validates :cnpj, length: { is: 14 }, uniqueness: true, numericality: { only_integer: true }
  validates :name, length: { minimum: 3, maximum: 255 }

  scope :by_cnpj, ->(cnpj) { where(cnpj:) }

  def debit_product_stock(product, amount)
    store_product = store_products.find_by(product_id: product.id)
    store_product.decrease_amount(amount)
  end

  def product_amount_in_stock?(product)
    store_product = store_products.find_by(product_id: product.id)
    sale_product = sales.find_by(product_id: product.id)
    store_product.amount >= sale_product.amount
  end
end
