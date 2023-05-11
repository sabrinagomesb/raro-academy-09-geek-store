# frozen_string_literal: true

FactoryBot.define do
  factory :sale_products do
    sale
    product
    amount { Faker::Number.number(digits: 2) }
  end
end
