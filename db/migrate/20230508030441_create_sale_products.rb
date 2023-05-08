# frozen_string_literal: true

class CreateSaleProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :sale_products do |t|
      t.references :product, null: false, foreign_key: true
      t.references :sale, null: false, foreign_key: true
      t.integer :amount, null: false, default: 1

      t.timestamps
    end
  end
end
