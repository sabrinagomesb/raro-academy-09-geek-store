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

  describe 'Model' do
    subject(:product) { build(:product) }

    it 'is valid when all attributes are valid' do
      product.save
      expect(product.errors).to be_empty
    end

    it 'is invalid when name is nil' do
      product.name = nil
      expect(product).not_to be_valid

      product.save
      expect(product.errors[:name]).to include("can't be blank")
    end

    it 'is invalid when description is nil' do
      product.description = nil
      expect(product).not_to be_valid

      product.save
      expect(product.errors[:description]).to include("can't be blank")
    end

    it 'is invalid when unit_price is nil' do
      product.unit_price = nil
      expect(product).not_to be_valid

      product.save
      expect(product.errors[:unit_price]).to include("can't be blank")
    end

    it 'is invalid when name is less than 3 characters long' do
      product.name = 'ab'
      expect(product).not_to be_valid

      product.save
      expect(product.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    it 'is invalid when name is more than 255 characters long' do
      product.name = 'a' * 256
      expect(product).not_to be_valid

      product.save
      expect(product.errors[:name]).to include('is too long (maximum is 255 characters)')
    end

    it 'is invalid when unit_price is zero' do
      product.unit_price = 0
      expect(product).not_to be_valid

      product.save
      expect(product.errors[:unit_price]).to include('must be greater than 0')
    end

    it 'is invalid when unit_price is negative' do
      product.unit_price = -42
      expect(product).not_to be_valid

      product.save
      expect(product.errors[:unit_price]).to include('must be greater than 0')
    end
  end
end
