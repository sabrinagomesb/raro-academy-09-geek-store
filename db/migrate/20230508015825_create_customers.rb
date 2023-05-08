# frozen_string_literal: true

class CreateCustomers < ActiveRecord::Migration[7.0]
  def change
    create_table :customers do |t|
      t.string :name, null: false, limit: 255
      t.string :cpf, null: false, limit: 11, unique: true

      t.timestamps
    end
  end
end
