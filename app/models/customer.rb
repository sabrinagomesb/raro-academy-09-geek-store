# frozen_string_literal: true

class Customer < ApplicationRecord
  has_one :addresses, as: :addressable, dependent: :destroy
  has_many :sales, inverse_of: :customer, dependent: :restrict_with_error
end
