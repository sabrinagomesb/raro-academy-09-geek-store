# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SaleProduct, type: :model do
  describe 'Associations' do
    it { is_expected.to belong_to(:product) }
    it { is_expected.to belong_to(:sale) }
  end

  describe 'Validations' do
    subject(:sale_product) { build(:sale_product) }
    it 'should be valid with valid attributes' do
      expect(sale_product).to be_valid
    end
  end

  describe 'Scopes' do
    let(:sale_product) { create(:sale_product, amount: 10) }
    let(:sale_product_b) { create(:sale_product, amount: 0) }

    it 'should return only the sold more products' do
      expect(described_class.sold_more_than(5)).to eq [sale_product]
    end

    it 'should return only the sold less products' do
      expect(described_class.sold_less_than(5)).to eq [sale_product_b]
    end

    it 'should return by_amount' do
      expect(described_class.by_amount(10)).to eq [sale_product]
    end
  end

  describe 'Methods' do
    context '#total_price' do
      let(:sale_product) { create(:sale_product, amount: 10) }

      it 'should calcule the total price' do
        result = sale_product.product.unit_price * 10
        expect(sale_product.total_price).to eq result
      end
    end

    context '#update_sale_total_price' do
      let(:sale_product) { create(:sale_product, amount: 10) }

      it 'should update the total price' do
        expect(sale_product.sale.total_price).to eq 0
        sale_product.update_sale_total_price
        expect(sale_product.sale.total_price).to eq sale_product.total_price
      end
    end
  end
end
