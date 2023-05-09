# frozen_string_literal: true

class RemoveDefaultFromInvoiceInSales < ActiveRecord::Migration[7.0]
  def change
    change_column_default :sales, :invoice, nil
  end
end
