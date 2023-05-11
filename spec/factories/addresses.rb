# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    city_id { create(:city).id }
    public_place { Faker::Address.street_name }
    zip_code { Faker::Number.number(digits: 8).to_s }
    number { Faker::Address.building_number.to_s }
    neighborhood { Faker::Address.community }
    reference { Faker::Address.secondary_address }
    complement { Faker::Address.secondary_address }
    addressable { create(:customer) }
  end
end
