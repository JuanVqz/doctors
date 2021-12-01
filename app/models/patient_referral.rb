class PatientReferral < ApplicationRecord
  enum importance: [:electivo, :urgente]

  belongs_to :patient
  belongs_to :doctor
  belongs_to :referred_doctor
  belongs_to :hospital

  scope :by_hospital, ->(hospital_id) { where hospital_id: hospital_id }
end
