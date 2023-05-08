# frozen_string_literal: true

class CreateSales < ActiveRecord::Migration[7.0]
  def change
    create_table :sales do |t|
      t.references :store, null: false, foreign_key: true
      t.references :customer, null: false, foreign_key: true
      t.datetime :finished_at, null: true
      t.decimal :total_amount, null: false, precision: 10, scale: 2
      t.boolean :finished, null: false, default: false

      t.timestamps
    end
  end
end
