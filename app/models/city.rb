# frozen_string_literal: true

class City < ApplicationRecord
  include ModelsValidators
  include NameScopes

  belongs_to :state, inverse_of: :cities

  validates :name, presence: true
  validate :name_allowed_length

  scope :from_state_by_name, ->(state_name) { joins(:state).where(states: { name: state_name }) }
  scope :from_state_by_acronym, ->(state_acronym) { joins(:state).where(states: { acronym: state_acronym }) }
end
