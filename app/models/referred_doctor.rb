class ReferredDoctor < ApplicationRecord
  belongs_to :doctor
  has_one :address, as: :addressable, dependent: :destroy
  has_many :hospitalizations

  accepts_nested_attributes_for :address, allow_destroy: true

  validates :full_name, :specialty, presence: true

  scope :by_doctor, -> (doctor_id) { where(doctor_id: doctor_id) }

  delegate :street, :number, :colony, :postal_code, :municipality,
    :state, :country, to: :address, prefix: true, allow_nil: true

  def to_s
    "#{full_name}".titleize
  end
end
