# frozen_string_literal: true

class City < ApplicationRecord
  include ModelsValidators

  belongs_to :state, inverse_of: :cities

  validates :name, presence: true
  validate :name_allowed_length
end
