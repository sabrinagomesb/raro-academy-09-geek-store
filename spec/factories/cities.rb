# frozen_string_literal: true

FactoryBot.define do
  factory :city do
    name { Faker::Alphanumeric.alpha(number: 5) }
    state
  end
end
