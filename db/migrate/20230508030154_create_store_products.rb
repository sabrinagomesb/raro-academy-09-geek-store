# frozen_string_literal: true

class CreateStoreProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :store_products do |t|
      t.references :store, null: false, foreign_key: true
      t.references :product, null: false, foreign_key: true
      t.integer :amount, null: false, default: 0

      t.timestamps
    end
  end
end
