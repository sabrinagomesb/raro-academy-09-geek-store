# frozen_string_literal: true

class RenameTotalAmountColumnInSales < ActiveRecord::Migration[7.0]
  def change
    rename_column :sales, :total_amount, :total_price
  end
end
