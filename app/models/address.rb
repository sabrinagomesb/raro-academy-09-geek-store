# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :city
  has_one :state, through: :city
end
