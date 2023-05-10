# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Customer do
  describe 'Associations' do
    it { should have_many(:sales).dependent(:destroy) }
    it { should have_one(:address).dependent(:destroy) }
  end

  describe 'Validations' do
    subject(:customer) { build(:customer) }
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cpf) }
    it { should validate_length_of(:cpf).is_equal_to(11) }

    it {
      expect(customer).to validate_length_of(:name)
        .is_at_least(3)
        .with_long_message('is too short (minimum is 3 characters)')
    }

    it {
      expect(customer).to validate_length_of(:name)
        .is_at_most(255)
        .with_long_message('is too long (maximum is 255 characters)')
    }
  end
end
