# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :city
  belongs_to :addressable, polymorphic: true

  has_one :state, through: :city
  has_one :customers, inverse_of: :address, dependent: :destroy
  has_one :stores, inverse_of: :address, dependent: :destroy
  has_one :suppliers, inverse_of: :address, dependent: :destroy
end
