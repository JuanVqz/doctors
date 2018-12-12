class Hospitalization < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :starting, :ending, :patient, :days_of_stay, presence: true
  validates :days_of_stay, numericality: { greater_than: 0 }

  scope :per_doctor, -> (doctor_id) { where(doctor_id: doctor_id) }
  scope :per_patient, -> (patient_id) { where(patient_id: patient_id) }
  scope :by_doctor_and_patient, -> (doctor_id, patient_id) { per_doctor(doctor_id).per_patient(patient_id) }

  def self.search query
    where("reason_for_hospitalization ILIKE ?", "%#{query}%")
      .or(where("treatment ILIKE ?", "%#{query}%"))
  end
end