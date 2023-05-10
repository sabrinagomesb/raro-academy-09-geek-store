# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Store do
  describe 'Associations' do
    it { should have_one(:address).dependent(:destroy) }
    it { should have_many(:sales).dependent(:destroy) }
    it { should have_many(:store_products).dependent(:destroy) }
    it { should have_many(:products).through(:store_products) }
  end

  describe 'Validations' do
    subject(:store) { build(:store) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cnpj) }
    it { should validate_length_of(:cnpj).is_equal_to(14) }

    it {
      expect(store).to validate_length_of(:name)
        .is_at_least(3)
        .with_long_message('is too short (minimum is 3 characters)')
    }

    it {
      expect(store).to validate_length_of(:name)
        .is_at_most(255)
        .with_long_message('is too long (maximum is 255 characters)')
    }
  end
end
