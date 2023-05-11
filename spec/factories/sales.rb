# frozen_string_literal: true

FactoryBot.define do
  factory :sale do
    store
    customer
    total_price { Faker::Number.decimal(l_digits: 2) }
    invoice { Faker::Number.number(digits: 10).to_s }
  end
end
