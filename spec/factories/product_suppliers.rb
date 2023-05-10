# frozen_string_literal: true

FactoryBot.define do
  factory :product_suppliers do
    product
    supplier
  end
end
