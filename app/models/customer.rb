# frozen_string_literal: true

class Customer < ApplicationRecord
  include NameScopes

  has_many :sales, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy

  validates :name, :cpf, presence: true

  validates :cpf, length: { is: 11 }, uniqueness: true, numericality: { only_integer: true }
  validates :name, length: { minimum: 3, maximum: 255 }

  scope :by_cpf, ->(cpf) { where(cpf:) }
  scope :with_sales_by_store, ->(store_id) { joins(:sales).where(sales: { store_id: }).uniq }
  scope :with_finished_sales, -> { joins(:sales).where(sales: { finished: true }).pluck(:name).uniq }
  scope :with_unfinished_sales, -> { joins(:sales).where(sales: { finished: false }).pluck(:name).uniq }

  before_destroy :check_sales_presence

  private

  def check_sales_presence
    throw(:abort) if sales.exists?
  end
end
