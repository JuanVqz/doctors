class ReferredDoctor < ApplicationRecord
  belongs_to :doctor
  has_one :address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true

  validates :full_name, :specialty, presence: true

  delegate :street, :number, :colony, :postal_code, :municipality,
    :state, :country, to: :address, prefix: true, allow_nil: true
end