# frozen_string_literal: true

class AddAddressableToAddresses < ActiveRecord::Migration[7.0]
  def change
    add_reference :addresses, :addressable, polymorphic: true
  end
end
