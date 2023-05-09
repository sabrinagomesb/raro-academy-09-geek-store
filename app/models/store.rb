# frozen_string_literal: true

class Store < ApplicationRecord
  include ModelsValidators

  has_many :store_products, dependent: :destroy
  has_many :products, through: :store_products
  has_many :sales, dependent: :destroy
  has_one :addresses, as: :addressable, dependent: :destroy

  validates :name, :cnpj, presence: true
  validates :cnpj, length: { is: 14 }
  validate :name_allowed_length
end
