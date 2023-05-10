# frozen_string_literal: true

class Customer < ApplicationRecord
  has_many :sales, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy

  validates :name, :cpf, presence: true

  validates :cpf, length: { is: 11 }
  validates :name, length: { minimum: 3, maximum: 255 }
end
