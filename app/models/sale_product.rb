# frozen_string_literal: true

class SaleProduct < ApplicationRecord
  belongs_to :product
  belongs_to :sale
end
