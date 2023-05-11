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

  describe 'Model' do
    subject(:customer) { build(:customer) }

    it 'is valid when all attributes are valid' do
      customer.save
      expect(customer.errors).to be_empty
    end

    it 'is invalid when name is nil' do
      customer.name = nil
      expect(customer).not_to be_valid

      customer.save
      expect(customer.errors[:name]).to include("can't be blank")
    end

    it 'is invalid when cpf is nil' do
      customer.cpf = nil
      expect(customer).not_to be_valid

      customer.save
      expect(customer.errors[:cpf]).to include("can't be blank")
    end

    it 'is invalid when cpf is not 11 characters long' do
      customer.cpf = '1'
      expect(customer).not_to be_valid

      customer.save
      expect(customer.errors[:cpf]).to include('is the wrong length (should be 11 characters)')

      customer.cpf = '111222333444555'
      expect(customer).not_to be_valid

      customer.save
      expect(customer.errors[:cpf]).to include('is the wrong length (should be 11 characters)')
    end

    it 'is invalid when name is less than 3 characters long' do
      customer.name = 'ab'
      expect(customer).not_to be_valid

      customer.save
      expect(customer.errors[:name]).to include('is too short (minimum is 3 characters)')
    end

    it 'is invalid when name is more than 255 characters long' do
      customer.name = 'a' * 256
      expect(customer).not_to be_valid

      customer.save
      expect(customer.errors[:name]).to include('is too long (maximum is 255 characters)')
    end

    it 'is invalid when cpf is not unique' do
      customer.save
      expect(customer.errors).to be_empty

      another_customer = build(:customer, cpf: customer.cpf)
      another_customer.save
      expect(another_customer.errors[:cpf]).to include('has already been taken')
    end

    it 'is invalid when cpf is not a number' do
      customer.cpf = '123456789ab'
      expect(customer).not_to be_valid

      customer.save
      expect(customer.errors[:cpf]).to include('is not a number')
    end
  end

  describe 'Scopes' do
    context 'when searching by_cpf' do
      it 'should returns the correct customer' do
        customer = create(:customer)
        customer2 = create(:customer)

        expect(Customer.by_cpf(customer.cpf)).to eq([customer])
        expect(Customer.by_cpf(customer2.cpf)).to eq([customer2])
      end

      it 'should returns an empty array when no customer is found' do
        expect(Customer.by_cpf('12345678912345')).to eq([])
      end

      it 'should returns an empty array when cpf is nil' do
        expect(Customer.by_cpf(nil)).to eq([])
      end
    end

    context 'when searching with_finished_sales' do
      let(:customer) { create(:customer) }
      let(:customer1) { create(:customer) }
      let(:store) { create(:store) }
      let(:sale) { create(:sale, store:, customer:) }

      it 'should returns the correct customers' do
        sale.update(finished: true)
        expect(Customer.with_finished_sales).to eq([customer.name])
      end

      it 'should not returns the incorrect customers' do
        sale.update(finished: true)
        expect(Customer.with_finished_sales).not_to eq([customer1.name])
      end

      it 'should returns an empty array when no customer is found' do
        expect(Customer.with_finished_sales).to eq([])
      end
    end

    context 'when searching with_unfinished_sales' do
      let(:customer) { create(:customer) }
      let(:customer1) { create(:customer) }
      let(:store) { create(:store) }
      let(:sale) { create(:sale, store:, customer:) }

      it 'should returns the correct customers' do
        sale.update(finished: false)
        expect(Customer.with_unfinished_sales).to eq([customer.name])
      end

      it 'should not returns the incorrect customers' do
        sale.update(finished: false)
        expect(Customer.with_unfinished_sales).not_to eq([customer1.name])
      end

      it 'should returns an empty array when no customer is found' do
        expect(Customer.with_unfinished_sales).to eq([])
      end
    end
  end
end
