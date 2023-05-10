# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Supplier do
  describe 'Associations' do
    it { should have_one(:address).dependent(:destroy) }
    it { should have_many(:product_suppliers).dependent(:destroy) }
    it { should have_many(:products).through(:product_suppliers) }
  end

  describe 'Validations' do
    subject(:supplier) { build(:supplier) }

    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:cnpj) }
    it { should validate_length_of(:cnpj).is_equal_to(14) }

    it {
      expect(supplier).to validate_length_of(:name)
        .is_at_least(3)
        .with_long_message('is too short (minimum is 3 characters)')
    }

    it {
      expect(supplier).to validate_length_of(:name)
        .is_at_most(255)
        .with_long_message('is too long (maximum is 255 characters)')
    }
  end

  describe 'Model' do
    subject(:supplier) { build(:supplier) }

    it 'is valid when all attributes are valid' do
      supplier.save
      expect(supplier.errors).to be_empty
    end

    it 'is invalid when name is nil' do
      supplier.name = nil
      expect(supplier).not_to be_valid

      supplier.save
      expect(supplier.errors[:name]).to include("can't be blank")
    end

    it 'is invalid when cnpj is nil' do
      supplier.cnpj = nil
      expect(supplier).not_to be_valid

      supplier.save
      expect(supplier.errors[:cnpj]).to include("can't be blank")
    end

    it 'is invalid when cnpj is not 14 characters long' do
      supplier.cnpj = '1'
      expect(supplier).not_to be_valid

      supplier.save
      expect(supplier.errors[:cnpj]).to include('is the wrong length (should be 14 characters)')

      supplier.cnpj = '123164549789765121321564'
      expect(supplier).not_to be_valid

      supplier.save
      expect(supplier.errors[:cnpj]).to include('is the wrong length (should be 14 characters)')
    end

    it 'is invalid when cnpj is not unique' do
      supplier.save
      expect(supplier.errors).to be_empty

      supplier2 = build(:supplier, cnpj: supplier.cnpj)
      supplier2.save
      expect(supplier2.errors[:cnpj]).to include('has already been taken')
    end

    it 'is invalid when cnpj is not a number' do
      supplier.cnpj = '123456789abcd'
      expect(supplier).not_to be_valid

      supplier.save
      expect(supplier.errors[:cnpj]).to include('is not a number')
    end

    it 'is invalid when name is less than 3 characters long' do
      supplier.name = 'a'
      expect(supplier).not_to be_valid

      supplier.save
      expect(supplier.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    it 'is invalid when name is more than 255 characters long' do
      supplier.name = 'a' * 256
      expect(supplier).not_to be_valid

      supplier.save
      expect(supplier.errors[:name]).to include('is too long (maximum is 255 characters)')
    end
  end

  describe 'Scopes' do
    context 'when searching by_cnpj' do
      it 'returns the correct supplier' do
        supplier = create(:supplier)
        supplier2 = create(:supplier)

        expect(Supplier.by_cnpj(supplier.cnpj)).to eq([supplier])
        expect(Supplier.by_cnpj(supplier2.cnpj)).to eq([supplier2])
      end

      it 'returns an empty array when no supplier is found' do
        expect(Supplier.by_cnpj('12345678912345')).to eq([])
      end

      it 'returns an empty array when cnpj is nil' do
        expect(Supplier.by_cnpj(nil)).to eq([])
      end
    end
  end
end
