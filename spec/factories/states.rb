# frozen_string_literal: true

FactoryBot.define do
  factory :state do
    name { Faker::Alphanumeric.alpha(number: 3) }
    acronym { Faker::Lorem.characters(number: 2, min_alpha: 2, min_numeric: 0).upcase }

    trait :mg do
      name { 'Minas Gerais' }
      acronym { 'MG' }
    end
  end
end
