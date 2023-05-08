# frozen_string_literal: true

class StoreProduct < ApplicationRecord
  belongs_to :product
  belongs_to :store
end
