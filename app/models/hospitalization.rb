class Hospitalization < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :starting, :ending, :patient_id, presence: true

  scope :per_doctor, -> (doctor_id) { where(doctor_id: doctor_id) }
  scope :per_patient, -> (patient_id) { where(patient_id: patient_id) }
  scope :by_doctor_and_patient, -> (doctor_id, patient_id) { per_doctor(doctor_id).per_patient(patient_id) }
end
