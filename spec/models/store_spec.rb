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

  describe 'Model' do
    subject(:store) { build(:store) }

    it 'is valid when all attributes are valid' do
      store.save
      expect(store.errors).to be_empty
    end

    it 'is invalid when name is nil' do
      store.name = nil
      expect(store).not_to be_valid

      store.save
      expect(store.errors[:name]).to include("can't be blank")
    end

    it 'is invalid when cnpj is nil' do
      store.cnpj = nil
      expect(store).not_to be_valid

      store.save
      expect(store.errors[:cnpj]).to include("can't be blank")
    end

    it 'is invalid when cnpj is not 14 characters long' do
      store.cnpj = '1'
      expect(store).not_to be_valid

      store.save
      expect(store.errors[:cnpj]).to include('is the wrong length (should be 14 characters)')

      store.cnpj = '123456789746541321654849'
      expect(store).not_to be_valid

      store.save
      expect(store.errors[:cnpj]).to include('is the wrong length (should be 14 characters)')
    end

    it 'is invalid when cnpj is not only numbers' do
      store.cnpj = '123456789abcde'
      expect(store).not_to be_valid

      store.save
      expect(store.errors[:cnpj]).to include('is not a number')
    end

    it 'is invalid when name is less than 3 characters long' do
      store.name = '12'
      expect(store).not_to be_valid

      store.save
      expect(store.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    it 'is invalid when name is more than 255 characters long' do
      store.name = 'a' * 256
      expect(store).not_to be_valid

      store.save
      expect(store.errors[:name]).to include('is too long (maximum is 255 characters)')
    end
  end

  describe 'Scopes' do
    context 'when searching by_cnpj' do
      it 'returns the correct store' do
        store = create(:store)
        store2 = create(:store)

        expect(Store.by_cnpj(store.cnpj)).to eq([store])
        expect(Store.by_cnpj(store2.cnpj)).to eq([store2])
      end

      it 'returns an empty array when no store is found' do
        expect(Store.by_cnpj('12345678912345')).to eq([])
      end

      it 'returns an empty array when cnpj is nil' do
        expect(Store.by_cnpj(nil)).to eq([])
      end
    end
  end
end
