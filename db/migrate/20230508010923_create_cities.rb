# frozen_string_literal: true

class CreateCities < ActiveRecord::Migration[7.0]
  def change
    create_table :cities do |t|
      t.string :name, null: false, limit: 255
      t.references :state, null: false, foreign_key: true

      t.timestamps
    end
  end
end
