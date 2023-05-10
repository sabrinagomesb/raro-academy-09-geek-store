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

  scope :by_city, ->(city) { where(city:) }
  scope :by_state, ->(state) { from('addresses INNER JOIN cities ON addresses.city_id = cities.id').where('cities.state_id = ?', state) }
  scope :by_zip_code, ->(zip_code) { where(zip_code: zip_code) }
  scope :by_public_place, ->(public_place) { where(public_place: public_place) }
  scope :by_number, ->(number) { where(number: number) }
  scope :by_neighborhood, ->(neighborhood) { where(neighborhood: neighborhood) }
  scope :by_reference, ->(reference) { where(reference: reference) }
  scope :by_complement, ->(complement) { where(complement: complement) }
  scope :by_addressable, ->(addressable) { where(addressable: addressable) }
end

# incluo validação pra bairro?
