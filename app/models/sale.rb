# frozen_string_literal: true

class Sale < ApplicationRecord
  belongs_to :store
  belongs_to :customer
end
