class PatientReferral < ApplicationRecord
  enum importance: [:electivo, :urgente]

  belongs_to :patient
  belongs_to :doctor
  belongs_to :referred_doctor
  belongs_to :hospital
end
