# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StoreProduct, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:store) }
  end

  describe 'Validations' do
    subject(:store_product) { build(:store_product) }

    it { is_expected.to validate_presence_of(:amount) }

    it {
      expect(store_product).to validate_numericality_of(:amount)
        .only_integer
    }

    it 'should be valid with valid attributes' do
      expect(store_product).to be_valid
    end
  end

  describe 'Scopes' do
    let(:store_product) { create(:store_product, amount: 10) }
    let(:store_product_b) { create(:store_product, amount: 0) }

    it 'should return only the store products with amount greater than 0' do
      expect(described_class.in_stock).to eq [store_product]
    end

    it 'should return only the store products with amount equal to 0' do
      expect(described_class.out_of_stock).to eq [store_product_b]
    end

    it 'should return only the store products with the store_id passed' do
      expect(described_class.by_store(store_product.store_id)).to eq [store_product]
    end

    it 'should return only the store products with the product_id passed' do
      expect(described_class.by_product(store_product.product_id)).to eq [store_product]
    end
  end

  describe 'Callbacks' do
    context 'when instance call increase_amount' do
      let(:store_product) { create(:store_product, amount: 10) }

      it 'should increase the amount of the store product' do
        expect { store_product.increase_amount(5) }.to change { store_product.amount }.by(5)
      end

      it 'should not increase the amount of the store product if the amount is less than 0' do
        expect { store_product.increase_amount(-5) }.not_to change { store_product.amount }
      end
    end

    context 'when instance call decrease_amount' do
      let(:store_product) { create(:store_product, amount: 10) }

      it 'should decrease the amount of the store product' do
        expect { store_product.decrease_amount(5) }.to change { store_product.amount }.by(-5)
      end

      it 'should not decrease the amount of the store product if the amount is greater than the current amount' do
        expect { store_product.decrease_amount(15) }.not_to change { store_product.amount }
      end
    end

    context 'when class call increase_amount' do
      let(:store_product) { create(:store_product, amount: 10) }

      it 'should increase the amount of the store product' do
        expect { described_class.increase_amount(store_product.store_id, store_product.product_id, 5) }.to change {
                                                                                                             store_product.reload.amount
                                                                                                           }.by(5)
      end

      it 'should not increase the amount of the store product if the amount is less than 0' do
        expect { described_class.increase_amount(store_product.store_id, store_product.product_id, -5) }.not_to change {
                                                                                                                  store_product.reload.amount
                                                                                                                }
      end
    end

    context 'when class call decrease_amount' do
      let(:store_product) { create(:store_product, amount: 10) }

      it 'should decrease the amount of the store product' do
        expect { described_class.decrease_amount(store_product.store_id, store_product.product_id, 5) }.to change {
                                                                                                             store_product.reload.amount
                                                                                                           }.by(-5)
      end

      it 'should not decrease the amount of the store product if the amount is greater than the current amount' do
        expect { described_class.decrease_amount(store_product.store_id, store_product.product_id, 15) }.not_to change {
                                                                                                                  store_product.reload.amount
                                                                                                                }
        expect { described_class.decrease_amount(store_product.store_id, store_product.product_id, 11) }.not_to change {
                                                                                                                  store_product.reload.amount
                                                                                                                }
      end
    end
  end
end
