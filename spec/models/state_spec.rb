# frozen_string_literal: true

require 'rails_helper'

RSpec.describe State, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:cities).dependent(:destroy).inverse_of(:state) }
  end

  describe 'Validations' do
    subject(:state) { build(:state) }

    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:acronym) }

    it {
      expect(state).to validate_length_of(:name)
        .is_at_least(3)
        .with_long_message('is too short (minimum is 3 characters)')
    }

    it {
      expect(state).to validate_length_of(:name)
        .is_at_most(255)
        .with_long_message('is too long (maximum is 255 characters)')
    }

    it {
      expect(state).to validate_length_of(:acronym)
        .is_equal_to(2)
    }

    it {
      expect(state).to validate_uniqueness_of(:name).case_insensitive
    }

    it {
      expect(state).to validate_uniqueness_of(:acronym).case_insensitive
    }

    it {
      expect(state).to accept_nested_attributes_for(:cities).allow_destroy(true)
    }
  end

  describe 'Callbacks' do
    subject(:state) { described_class.new(name: 'anything', acronym: 'an') }

    it 'should validate that the titled name is saved' do
      state.save
      expect(state.name).to eq 'anything'.downcase.titleize
    end

    it 'should validate that the acronym is saved in upper case' do
      state.save
      expect(state.acronym).to eq 'an'.upcase
    end
  end

  describe 'Model' do
    subject(:state) { build(:state) }

    it 'is invalid when name is nil' do
      state.name = nil
      expect(state).not_to be_valid

      state.save
      expect(state.errors[:name]).to include("can't be blank")
    end

    it 'is invalid when name is an empty string' do
      state.name = ''
      expect(state).not_to be_valid

      state.save
      expect(state.errors[:name]).to include("can't be blank")
    end

    it 'is invalid when acronym is nil' do
      state.acronym = nil
      expect(state).not_to be_valid

      state.save
      expect(state.errors[:acronym]).to eq ["can't be blank", 'is the wrong length (should be 2 characters)']
    end

    it 'is invalid when acronym is an empty string' do
      state.acronym = ''
      expect(state).not_to be_valid

      state.save
      expect(state.errors[:acronym]).to eq ["can't be blank", 'is the wrong length (should be 2 characters)']
    end

    it 'is invalid when character limit for name exceeds the maximum allowed' do
      state.name = Faker::Lorem.characters(number: 256)
      expect(state).not_to be_valid

      state.save
      expect(state.errors[:name]).to include('is too long (maximum is 255 characters)')
    end

    it 'is invalid when character limit for acronym is less than 2' do
      state.acronym = Faker::Lorem.characters(number: 1).upcase
      expect(state).not_to be_valid

      state.save
      expect(state.errors[:acronym]).to eq ['is the wrong length (should be 2 characters)']
    end

    it 'is invalid when there is already a state with the same name' do
      described_class.create!(name: 'Anything', acronym: 'AN')
      state.name = 'anything'
      expect(state).not_to be_valid

      state.save
      expect(state.errors[:name]).to eq ['has already been taken']
    end

    it 'is invalid when there is already a state with the same acronym' do
      described_class.create!(name: 'Anything', acronym: 'AN')
      state.acronym = 'an'
      expect(state).not_to be_valid

      state.save
      expect(state.errors[:acronym]).to eq ['has already been taken']
    end

    it 'is invalid when name and acronym are invalids' do
      state.name = ''
      state.acronym = ''
      expect(state).not_to be_valid

      state.save
      expect(state.errors[:acronym]).to eq ["can't be blank", 'is the wrong length (should be 2 characters)']
    end

    it 'is valid when all attributes are valid' do
      expect(state).to be_valid

      state.save
      expect(state.errors).to be_empty
    end
  end
end
