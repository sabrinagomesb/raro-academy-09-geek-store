# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  describe 'Associations' do
    it { is_expected.to belong_to(:city) }
    it { is_expected.to belong_to(:addressable) }
    it { should have_one(:state).through(:city) }
    # it { should have_one(:customer).dependent(:destroy).inverse_of(:address) }
    # it { should have_one(:store).dependent(:destroy).inverse_of(:address) }
    # it { should have_one(:supplier).dependent(:destroy).inverse_of(:address) }
  end

  describe 'Validations' do
    subject(:address) { build(:address) }

    it { is_expected.to validate_presence_of(:zip_code) }
    it { is_expected.to validate_presence_of(:public_place) }
    it { is_expected.to validate_presence_of(:number) }
    it { is_expected.to validate_presence_of(:neighborhood) }
    it { is_expected.to validate_length_of(:zip_code).is_equal_to(8) }
    it { is_expected.to validate_length_of(:reference).is_at_most(255) }
    it { is_expected.to validate_length_of(:complement).is_at_most(255) }
  end

  describe 'Model' do
    subject(:address) { build(:address) }
    subject(:customer) { build(:customer) }

    it 'is valid when all attributes are valid' do
      address.save
      expect(address.errors).to be_empty
    end

    it 'is invalid when zip_code is nil' do
      address.zip_code = nil
      expect(address).not_to be_valid

      address.save
      expect(address.errors[:zip_code]).to include("can't be blank")
    end

    it 'is invalid when public_place is nil' do
      address.public_place = nil
      expect(address).not_to be_valid

      address.save
      expect(address.errors[:public_place]).to include("can't be blank")
    end

    it 'is invalid when number is nil' do
      address.number = nil
      expect(address).not_to be_valid

      address.save
      expect(address.errors[:number]).to include("can't be blank")
    end

    it 'is invalid when neighborhood is nil' do
      address.neighborhood = nil
      expect(address).not_to be_valid

      address.save
      expect(address.errors[:neighborhood]).to include("can't be blank")
    end

    it 'is invalid when zip_code is not 8 characters long' do
      address.zip_code = '1'
      expect(address).not_to be_valid

      address.save
      expect(address.errors[:zip_code]).to include('is the wrong length (should be 8 characters)')
    end

    it 'is invalid when number is more than 15 characters long' do
      address.number = '1' * 16
      expect(address).not_to be_valid

      address.save
      expect(address.errors[:number]).to include('is too long (maximum is 15 characters)')
    end

    it 'is invalid when reference is more than 255 characters long' do
      address.reference = '1' * 256
      expect(address).not_to be_valid

      address.save
      expect(address.errors[:reference]).to include('is too long (maximum is 255 characters)')
    end

    it 'is invalid when complement is more than 255 characters long' do
      address.complement = '1' * 256
      expect(address).not_to be_valid

      address.save
      expect(address.errors[:complement]).to include('is too long (maximum is 255 characters)')
    end

    it 'is invalid when addressable is nil' do
      address.addressable = nil
      expect(address).not_to be_valid

      address.save
      expect(address.errors[:addressable]).to include("must exist")
    end
  end

  describe 'Scopes' do
    context 'when search by_city' do
      let(:city) { create(:city) }
      let(:address) { create(:address, city:) }

      it 'should returns addresses by city' do
        expect(Address.by_city(city)).to include(address)
      end
    end

    context 'when search by_state' do
      let(:state) { create(:state) }
      let(:city) { create(:city, state:) }
      let(:address) { create(:address, city:) }

      it 'should returns addresses by state' do
        expect(Address.by_state(state)).to include(address)
      end
    end

    context 'when search by_zip_code' do
      let(:address) { create(:address) }
      let(:address1) { create(:address) }

      it 'shouldreturns addresses by zip_code' do
        expect(Address.by_zip_code(address.zip_code)).to include(address)
      end

      it 'should not returns addresses by zip_code' do
        expect(Address.by_zip_code(address.zip_code)).not_to include(address1)
      end
    end

    context 'when search by_public_place' do
      let(:address) { create(:address) }
      let(:address1) { create(:address) }

      it 'should returns addresses by public_place' do
        expect(Address.by_public_place(address.public_place)).to include(address)
      end

      it 'should not returns addresses by public_place' do
        expect(Address.by_public_place(address.public_place)).not_to include(address1)
      end
    end

    context 'when search by_neighborhood' do
      let(:address) { create(:address) }
      let(:address1) { create(:address) }

      it 'should returns addresses by neighborhood' do
        expect(Address.by_neighborhood(address.neighborhood)).to include(address)
      end

      it 'should not returns addresses by neighborhood' do
        expect(Address.by_neighborhood(address.neighborhood)).not_to include(address1)
      end
    end

    context 'when search by_number' do
      let(:address) { create(:address) }
      let(:address1) { create(:address) }

      it 'should returns addresses by number' do
        expect(Address.by_number(address.number)).to include(address)
      end

      it 'should not returns addresses by number' do
        expect(Address.by_number(address.number)).not_to include(address1)
      end
    end

    context 'when search by_reference' do
      let(:address) { create(:address) }
      let(:address1) { create(:address) }

      it 'should returns addresses by reference' do
        expect(Address.by_reference(address.reference)).to include(address)
      end

      it 'should not returns addresses by reference' do
        expect(Address.by_reference(address.reference)).not_to include(address1)
      end
    end

    context 'when search by_complement' do
      let(:address) { create(:address) }
      let(:address1) { create(:address) }

      it 'should returns addresses by complement' do
        expect(Address.by_complement(address.complement)).to include(address)
      end

      it 'should not returns addresses by complement' do
        expect(Address.by_complement(address.complement)).not_to include(address1)
      end
    end

    context 'when search by_addressable' do
      let(:address) { create(:address) }
      let(:address1) { create(:address) }

      it 'should returns addresses by addressable' do
        expect(Address.by_addressable(address.addressable)).to include(address)
      end

      it 'should not returns addresses by addressable' do
        expect(Address.by_addressable(address.addressable)).not_to include(address1)
      end
    end
  end
end
