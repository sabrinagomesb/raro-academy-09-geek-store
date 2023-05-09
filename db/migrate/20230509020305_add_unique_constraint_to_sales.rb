# frozen_string_literal: true

class AddUniqueConstraintToSales < ActiveRecord::Migration[7.0]
  def change
    add_index :sales, :invoice, unique: true
  end
end
