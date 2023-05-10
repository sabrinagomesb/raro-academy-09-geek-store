# frozen_string_literal: true

require 'rails_helper'

RSpec.describe City, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:state).inverse_of(:cities) }
  end

  describe 'Validations' do
    subject(:city) { build(:city) }

    it { is_expected.to validate_presence_of(:name) }

    it {
      expect(city).to validate_length_of(:name)
        .is_at_least(3)
        .with_long_message('is too short (minimum is 3 characters)')
    }

    it {
      expect(city).to validate_length_of(:name)
        .is_at_most(255)
        .with_long_message('is too long (maximum is 255 characters)')
    }
  end

  describe 'Model' do
    subject(:city) { build(:city) }

    it 'is invalid when name is nil' do
      city.name = nil
      expect(city).not_to be_valid

      city.save
      expect(city.errors[:name]).to include("can't be blank")
    end

    it 'is invalid when name is an empty string' do
      city.name = ''
      expect(city).not_to be_valid

      city.save
      expect(city.errors[:name]).to include("can't be blank")
    end

    it 'is invalid when state is not defined' do
      city.state = nil
      expect(city).not_to be_valid

      city.save
      expect(city.errors[:state]).to eq ['must exist']
    end

    it 'is saved when all attributes is valid' do
      city.save
      expect(city.errors).to be_empty
    end
  end

  describe 'Scopes' do
    let!(:state_mg) { create(:state, :mg) }
    let!(:cities) { create_list(:city, 3, state: state_mg) }

    context 'when from_state_by_name' do
      it 'should returns an empty array if state_name is nil' do
        expect(described_class.from_state_by_name(nil)).to be_empty
      end

      it 'should returns an empty array if state_name is an empty string' do
        expect(described_class.from_state_by_name('')).to be_empty
      end

      it 'should returns an empty array if there are no cities for a given state' do
        expect(described_class.from_state_by_name('Ceará')).to be_empty
      end

      it 'should returns an array if there are cities for a given state' do
        expect(described_class.from_state_by_name('Minas Gerais')).to match_array cities
      end
    end

    context 'when from_state_by_acronym' do
      it 'should returns an empty array if acronym is nil' do
        expect(described_class.from_state_by_acronym(nil)).to be_empty
      end

      it 'should returns an empty array if acronym is an empty string' do
        expect(described_class.from_state_by_acronym('')).to be_empty
      end

      it 'should returns an empty array if there are no cities for a given state' do
        expect(described_class.from_state_by_acronym('CE')).to be_empty
      end

      it 'should returns an array if there are cities for a given state' do
        expect(described_class.from_state_by_acronym('MG')).to match_array cities
      end
    end
  end
end
