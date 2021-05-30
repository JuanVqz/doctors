class ReferredDoctor < ApplicationRecord
  belongs_to :doctor
  has_one :address, as: :addressable, dependent: :destroy

  validates :full_name, :specialty, presence: true
end
