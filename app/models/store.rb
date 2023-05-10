# frozen_string_literal: true

class Store < ApplicationRecord
  include NameScopes

  has_many :store_products, dependent: :destroy
  has_many :products, through: :store_products
  has_many :sales, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy

  validates :name, :cnpj, presence: true
  validates :cnpj, length: { is: 14 }
  validates :name, length: { minimum: 3, maximum: 255 }

  scope :by_cnpj, ->(cnpj) { where(cnpj:) }
end
