# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :sales, inverse_of: :customer, dependent: :destroy
  has_one :addresses, as: :addressable, dependent: :destroy
end
