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

  def check_product_stock(product_id)
    store_product = store_products.find_by(product_id:)

    if store_product.nil?
      errors.add(:base, "Produto não encontrado")
      return false
    end

    store_product.amount
  end

  def decrease_product_amount(product_id, amount)
    store_product = store_products.find_by(product_id:)

    if store_product.nil?
      errors.add(:base, "Produto não encontrado")
      return false
    end

    if store_product.amount < amount
      errors.add(:amount, "Quantidade insuficiente")
      return false
    end
    store_product.decrease_amount(amount)
  end

  def increase_product_amount(product_id, amount)
    store_product = store_products.find_by(product_id:)

    if store_product.nil?
      errors.add(:base, "Produto não encontrado")
      return false
    end

    if amount.negative?
      errors.add(:base, "Quantidade inválida")
      return false
    end

    store_product.increase_amount(amount)
  end
end
