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
end
