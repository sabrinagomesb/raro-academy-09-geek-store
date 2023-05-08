# frozen_string_literal: true

class CreateAddresses < ActiveRecord::Migration[7.0]
  def change
    create_table :addresses do |t|
      t.references :city, null: false, foreign_key: true
      t.string :public_place, null: false, limit: 255
      t.string :zip_code, null: false, limit: 8
      t.string :number, null: false, limit: 15
      t.string :neighborhood, null: false, limit: 255
      t.string :reference, null: true, limit: 255
      t.string :complement, null: true, limit: 255

      t.timestamps
    end
  end
end
