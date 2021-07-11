class Hospital < ApplicationRecord
  cattr_accessor :current_id

  enum plan: [:basic, :medium]

  has_one :address, as: :addressable, dependent: :destroy
  has_many :doctors, dependent: :destroy
  has_many :patient_referrals, dependent: :destroy

  accepts_nested_attributes_for :address, allow_destroy: true

  validates :subdomain, :name, presence: true
  validates :subdomain, :name, uniqueness: true

  def to_s
    name.titleize
  end
end
