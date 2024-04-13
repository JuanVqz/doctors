class Hospital < ApplicationRecord
  enum plan: {basic: 0, medium: 1}

  has_many :appointments, dependent: :destroy
  has_many :doctors, dependent: :destroy
  has_many :hospitalizations, dependent: :destroy
  has_many :patient_referrals, dependent: :destroy
  has_many :patients, dependent: :destroy
  has_many :referred_doctors, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true

  validates :subdomain, :name, presence: true
  validates :subdomain, :name, uniqueness: true

  def to_s
    name.titleize
  end
end
