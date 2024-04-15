# frozen_string_literal: true

class PatientReferral < ApplicationRecord
  enum importance: { electivo: 0, urgente: 1 }

  belongs_to :patient
  belongs_to :doctor
  belongs_to :referred_doctor
  belongs_to :hospital

  validates :patient_id, :doctor_id, :referred_doctor_id, :subject, :content, :importance, presence: true
end
