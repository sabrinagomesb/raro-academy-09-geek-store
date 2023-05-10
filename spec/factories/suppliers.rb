# frozen_string_literal: true

FactoryBot.define do
  factory :supplier do
    name { Faker::Name.name }
    cnpj { Faker::Company.brazilian_company_number }
  end
end
