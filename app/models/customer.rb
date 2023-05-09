# frozen_string_literal: true

class Customer < ApplicationRecord
  include ModelsValidators
  has_many :sales, dependent: :destroy
  has_one :addresses, as: :addressable, dependent: :destroy

  validates :name, :cpf, presence: true

  validates :cpf, length: { is: 11 }
  validate :name_allowed_length
end
