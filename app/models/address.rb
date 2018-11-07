class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :street, :colony, :postal_code, :municipality,
    :state, :country, presence: true
end
