class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :state, presence: true
end
