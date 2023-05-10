# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Product do
  describe 'Associations' do
    it { should have_many(:store_products).dependent(:destroy) }
    it { should have_many(:stores).through(:store_products) }
    it { should have_many(:product_suppliers).dependent(:destroy) }
    it { should have_many(:suppliers).through(:product_suppliers) }
    it { should have_many(:sale_products).dependent(:destroy) }
    it { should have_many(:sales).through(:sale_products) }
  end

  describe 'Validations' do
    subject(:product) { build(:product) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }

    it {
      expect(product).to validate_length_of(:name)
        .is_at_least(3)
        .with_long_message('is too short (minimum is 3 characters)')
    }

    it {
      expect(product).to validate_length_of(:name)
        .is_at_most(255)
        .with_long_message('is too long (maximum is 255 characters)')
    }

    context "when unit_price is zero" do
      let(:product) { build(:product, unit_price: 0) }

      it "is not valid" do
        expect(product).not_to be_valid
      end
    end

    context "when unit_price is positive" do
      let(:product) { build(:product, unit_price: 42) }

      it "is valid" do
        expect(product).to be_valid
      end
    end

    context "when unit_price is negative" do
      let(:product) { build(:product, unit_price: -42) }

      it "is not valid" do
        expect(product).not_to be_valid
      end
    end
  end
end
