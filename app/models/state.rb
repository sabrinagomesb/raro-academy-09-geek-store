# frozen_string_literal: true

class State < ApplicationRecord
  include ModelsValidators
  has_many :cities, dependent: :destroy, inverse_of: :state

  validates_associated :cities
  validates :name, :acronym, presence: true
  validates :acronym, length: { is: 2 }
  validate :name_allowed_length
end
