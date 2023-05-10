# frozen_string_literal: true

class Supplier < ApplicationRecord
  include NameScopes

  has_many :product_suppliers, dependent: :destroy
  has_many :products, through: :product_suppliers
  has_one :address, as: :addressable, dependent: :destroy

  validates :name, :cnpj, presence: true
  validates :cnpj, length: { is: 14 }
  validates :name, length: { minimum: 3, maximum: 255 }

  scope :by_cnpj, ->(cnpj) { where(cnpj:) }
end
