# frozen_string_literal: true

class CreateStates < ActiveRecord::Migration[7.0]
  def change
    create_table :states do |t|
      t.string :name, null: false, limit: 255
      t.string :acronym, null: false, limit: 2

      t.timestamps
    end
  end
end
