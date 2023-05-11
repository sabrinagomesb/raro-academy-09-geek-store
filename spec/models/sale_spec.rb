# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Sale do
  describe 'Associations' do
    it { should belong_to(:store) }
    it { should belong_to(:customer) }
    it { should have_many(:sale_products).dependent(:destroy) }
    it { should have_many(:products).through(:sale_products) }
  end

  describe 'Validations' do
    subject(:sale) { build(:sale) }

    it { should validate_presence_of(:total_price) }
    it { should validate_presence_of(:invoice) }
    it { should validate_length_of(:invoice).is_equal_to(10) }

    context "when total_price is zero" do
      let(:sale) { build(:sale, total_price: 0) }

      it "is valid" do
        expect(sale).to be_valid
      end
    end

    context "when total_price is positive" do
      let(:sale) { build(:sale) }

      it "is valid" do
        sale.total_price = 42
        expect(sale).to be_valid
      end
    end

    context "when total_price is negative" do
      let(:sale) { build(:sale) }

      it "is not valid" do
        sale.total_price = -42
        expect(sale).not_to be_valid
      end
    end
  end

  describe 'Model' do
    subject(:sale) { build(:sale) }

    it 'is valid when all attributes are valid' do
      sale.save
      expect(sale.errors).to be_empty
    end

    it 'is invalid when store is not defined' do
      sale.store = nil
      expect(sale).not_to be_valid

      sale.save
      expect(sale.errors[:store]).to include('must exist')
    end

    it 'is invalid when customer is not defined' do
      sale.customer = nil
      expect(sale).not_to be_valid

      sale.save
      expect(sale.errors[:customer]).to include('must exist')
    end

    it 'is invalid when total_price is not defined' do
      sale.total_price = nil
      expect(sale).not_to be_valid

      sale.save
      expect(sale.errors[:total_price]).to include("can't be blank")
    end

    it 'is invalid when invoice is not defined' do
      sale.invoice = nil
      expect(sale).not_to be_valid

      sale.save
      expect(sale.errors[:invoice]).to include("can't be blank")
    end

    it 'is invalid when invoice is not 10 characters long' do
      sale.invoice = '1'
      expect(sale).not_to be_valid

      sale.save
      expect(sale.errors[:invoice]).to include('is the wrong length (should be 10 characters)')

      sale.invoice = '111222333444555666777888'
      expect(sale).not_to be_valid

      sale.save
      expect(sale.errors[:invoice]).to include('is the wrong length (should be 10 characters)')
    end

    it 'is invalid when invoice is not a number' do
      sale.invoice = '123456789a'
      expect(sale).not_to be_valid

      sale.save
      expect(sale.errors[:invoice]).to include('is not a number')
    end

    it 'is invalid when invoice is not unique' do
      sale.save
      expect(sale.errors).to be_empty

      new_sale = build(:sale, invoice: sale.invoice)
      expect(new_sale).not_to be_valid

      new_sale.save
      expect(new_sale.errors[:invoice]).to include('has already been taken')
    end

    it 'is valid when finished is not defined' do
      expect(sale).to be_valid

      sale.save
      expect(sale.errors.empty?).to equal(true)
    end

    it 'should finished be false by default' do
      expect(sale.finished).to be false
    end

    it 'is invalid when total_price is not a number' do
      sale.total_price = 'abc'
      expect(sale).not_to be_valid

      sale.save
      expect(sale.errors[:total_price]).to include('is not a number')
    end

    it 'is invalid when total_price is negative' do
      sale.total_price = -42
      expect(sale).not_to be_valid

      sale.save
      expect(sale.errors[:total_price]).to include('must be greater than or equal to 0')
    end

    it 'is invalid when total_price is zero' do
      sale.total_price = 0
      expect(sale).to be_valid

      sale.save
      expect(sale.errors).to be_empty
    end
  end

  describe 'Scopes' do
    context 'when call finished method' do
      let(:sale) { create(:sale, finished: false) }

      it 'should returns only finished sales' do
        create(:sale, finished: true)
        create(:sale, finished: false)

        expect(Sale.finished.count).to eq(1)

        create(:sale, finished: true)
        expect(Sale.finished.count).to eq(2)
      end

      it 'should not returns unfinished sales' do
        expect(Sale.finished).not_to include(sale)
      end
    end

    context 'when call unfinished method' do
      let(:sale) { create(:sale, finished: true) }

      it 'should returns only unfinished sales' do
        create(:sale, finished: false)
        create(:sale, finished: true)

        expect(Sale.unfinished.count).to eq(1)

        create(:sale, finished: false)
        expect(Sale.unfinished.count).to eq(2)
      end

      it 'should not returns finished sales' do
        expect(Sale.unfinished).not_to include(sale)
      end
    end

    context 'when call from_store method' do
      let(:store) { create(:store) }
      let(:sale1) { create(:sale, store:) }
      let(:sale2) { create(:sale) }

      it 'should returns only sales from the store' do
        expect(Sale.from_store(store.id)).to include(sale1)
      end

      it 'should not returns sales from other stores' do
        expect(Sale.from_store(store.id)).not_to include(sale2)
      end
    end
  end

  describe 'Callbacks' do
    describe '#update_total_price' do
      context 'when there are no sale products' do
        let(:sale1) { create(:sale) }

        it 'sets the total price to 0' do
          expect(sale1.total_price.to_f).to eq(0)
        end
      end
    end

    # context 'when sale is finished' do
    #   let(:sale) { create(:sale) }
    #   let(:product) { create(:product) }
    #   let(:sale_product) { create(:sale_product, sale:, amount: 5) }

    #   it 'sets the sale_was_finished to true' do
    #     expect { sale.set_sale_was_finished }.to change { sale.finished }.from(false).to(true)
    #     expect { sale.finished_at }.not_to be_nil
    #     expect { sale.total_price }.not_to eq(0.0)
    #   end
    # end

    # context 'when sale is not finished' do
    #   let(:sale) { create(:sale, finished: false) }

    #   it 'sets the sale_was_finished to false' do
    #     expect(sale.set_sale_was_finished).to eq(false)
    #   end
    # end
    # end
  end
end
