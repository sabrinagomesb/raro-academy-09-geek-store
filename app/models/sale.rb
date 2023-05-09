# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :store
  belongs_to :customer

  has_many :sale_products, dependent: :destroy
  has_many :products, through: :sale_products

  validates :total_price, :invoice, presence: true
  validates :invoice, length: { is: 10 }
  validates :total_price, numericality: { is_greater_than_or_equal_to: 0 }, on: :update
  validates :finished, inclusion: [true, false]
end
