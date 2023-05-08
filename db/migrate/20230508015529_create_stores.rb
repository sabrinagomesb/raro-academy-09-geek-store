# frozen_string_literal: true

class CreateStores < ActiveRecord::Migration[7.0]
  def change
    create_table :stores do |t|
      t.string :name, null: false, limit: 255
      t.string :cnpj, null: false, limit: 14, unique: true

      t.timestamps
    end
  end
end
