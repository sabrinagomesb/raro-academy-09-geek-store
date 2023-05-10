# frozen_string_literal: true

class Supplier < ApplicationRecord
  include ModelsValidators
  include NameScopes

  has_many :product_suppliers, dependent: :destroy
  has_many :products, through: :product_suppliers
  has_one :addresses, as: :addressable, dependent: :destroy

  validates :name, :cnpj, presence: true
  validates :cnpj, length: { is: 14 }
  validate :name_allowed_length

  scope :by_cnpj, ->(cnpj) { where(cnpj:) }
end
