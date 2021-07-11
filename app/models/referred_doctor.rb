class ReferredDoctor < ApplicationRecord
  belongs_to :doctor
  has_one :address, as: :addressable, dependent: :destroy
  has_many :hospitalizations

  accepts_nested_attributes_for :address, allow_destroy: true

  validates :full_name, :specialty, presence: true
  validates :phone_number, format: { with: /\A\d+\z/, message: "acepta solo numeros" }, allow_blank: true
  validates_length_of :phone_number, is: 10, allow_blank: true

  scope :by_doctor, -> (doctor_id) { where(doctor_id: doctor_id) }

  delegate :street, :number, :colony, :postal_code, :municipality,
    :state, :country, to: :address, prefix: true, allow_nil: true

  def to_s
    "#{full_name}".titleize
  end
end
