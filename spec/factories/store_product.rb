# frozen_string_literal: true

FactoryBot.define do
  factory :store_products do
    store
    product
    amount { Faker::Number.number(digits: 2) }
  end
end
