# frozen_string_literal: true

FactoryBot.define do
  factory :store_product do
    store
    product
    amount { Faker::Number.number(digits: 2) }
  end
end
