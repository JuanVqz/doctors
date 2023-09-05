class ReferredDoctor < ApplicationRecord
  belongs_to :doctor
  has_one :address, as: :addressable, dependent: :destroy
  has_many :hospitalizations
  has_many :patient_referrals

  accepts_nested_attributes_for :address, allow_destroy: true

  validates :full_name, :specialty, presence: true
  validates :phone_number, format: {with: /\A\d+\z/, message: "acepta solo números"}, allow_blank: true
  validates :phone_number, length: {is: 10, allow_blank: true}

  scope :by_doctor, ->(doctor_id) { where(doctor_id: doctor_id) }

  delegate :street, :number, :colony, :postal_code, :municipality,
    :state, :country, to: :address, prefix: true, allow_nil: true

  def self.search(query)
    where("full_name ILIKE ? OR specialty ILIKE ? OR phone_number ILIKE ?", "%#{query}%", "%#{query}%", "%#{query}%")
  end

  def to_s
    full_name.to_s.titleize
  end
end
