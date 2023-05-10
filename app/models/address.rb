# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :city
  belongs_to :addressable, polymorphic: true

  has_one :state, through: :city
  has_one :customer, inverse_of: :address, dependent: :destroy
  has_one :stores, inverse_of: :address, dependent: :destroy
  has_one :suppliers, inverse_of: :address, dependent: :destroy

  validates :zip_code, :public_place, :number, :neighborhood, presence: true
  validates :zip_code, length: { is: 8 }
  validates :number, length: { maximum: 15 }
  validates :reference, :complement, allow_blank: true, length: { maximum: 255 }
end

# incluo validação pra bairro?
