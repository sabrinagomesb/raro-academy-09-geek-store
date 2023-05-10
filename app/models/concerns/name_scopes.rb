# frozen_string_literal: true

module NameScopes
  extend ActiveSupport::Concern

  included do
    scope :name_contains, ->(contain) { where("name LIKE ?", "%#{contain}%") }
    scope :by_name, ->(name) { where(name:) }
  end
end
