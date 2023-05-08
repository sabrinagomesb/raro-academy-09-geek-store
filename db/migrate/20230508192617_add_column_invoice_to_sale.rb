# frozen_string_literal: true

class AddColumnInvoiceToSale < ActiveRecord::Migration[7.0]
  def change
    add_column :sales, :invoice, :string, null: false, default: 0, limit: 255, after: :finished_at
  end
end
