# frozen_string_literal: true

class AddDefaultValueToTotalAmountInSales < ActiveRecord::Migration[7.0]
  def change
    change_column_default :sales, :total_amount, 0.0
  end
end
