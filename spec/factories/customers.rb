# frozen_string_literal: true

FactoryBot.define do
  factory :customer do
    name { Faker::Name.name }
    cpf { Faker::IDNumber.brazilian_cpf }
  end
end
