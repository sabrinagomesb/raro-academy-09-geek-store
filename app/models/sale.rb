# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :store
  belongs_to :customer

  has_many :sale_products, dependent: :destroy
  has_many :products, through: :sale_products

  validates :total_price, :invoice, presence: true
  validates :invoice, length: { is: 10 }, uniqueness: true, numericality: { only_integer: true }
  validates :total_price, numericality: { greater_than_or_equal_to: 0 }
  validates :finished, inclusion: { in: [true, false] }, allow_nil: false, on: :update

  scope :finished, -> { where(finished: true) }
  scope :unfinished, -> { where(finished: false) }
  scope :with_total_price_more_than, ->(amount) { where("total_price > ?", amount.to_f) }
  scope :with_total_price_less_than, ->(amount) { where("total_price < ?", amount.to_f) }
  scope :from_store, ->(store_id) { where(store_id:) }
  scope :total_finished_sales, -> { where(finished: true).sum(:total_price).to_f }

  accepts_nested_attributes_for :sale_products, allow_destroy: true

  before_create :set_total_price_to_zero

  def set_sale_was_finished
    all_products_available = sale_products.all? { |sp| sp.product_amount_in_stock(sp.product) == true }

    return unless all_products_available

    sale_products.each do |sale_product|
      store.debit_product_stock(sale_product.product, sale_product.amount)
    end

    self.finished = true
    self.finished_at = Time.zone.now
    self.total_price = find_total_price
    save!
  end

  def update_total_price
    self.total_price = find_total_price
  end

  private

  def set_total_price_to_zero
    self.total_price = 0
  end

  def find_total_price
    total_price = 0

    return total_price if products.empty? || products.nil?

    total_per_product = sale_products.map(&:total_price)
    total_per_product.each { |total| total_price += total }
    total_price
  end
end
