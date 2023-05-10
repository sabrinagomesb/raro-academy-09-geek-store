# frozen_string_literal: true

class Customer < ApplicationRecord
  include ModelsValidators
  include NameScopes

  has_many :sales, dependent: :destroy
  has_one :addresses, as: :addressable, dependent: :destroy

  validates :name, :cpf, presence: true

  validates :cpf, length: { is: 11 }
  validate :name_allowed_length

  scope :with_sales, -> { joins(:sales).uniq }
  scope :with_sales_by_store, ->(store_id) { joins(:sales).where(sales: { store_id: }).uniq }
  scope :with_finished_sales, -> { joins(:sales).where(sales: { finished: true }).pluck(:name).uniq }
end
