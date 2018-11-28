class MedicalConsultation < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :reason, :prescription, :patient_id, presence: true

  scope :per_doctor, -> (doctor_id) { where(doctor_id: doctor_id) }
  scope :per_patient, -> (patient_id) { where(patient_id: patient_id) }
  scope :by_doctor_and_patient, -> (doctor_id, patient_id) { per_doctor(doctor_id).per_patient(patient_id) }

  def self.search query
    where("LOWER(reason) LIKE LOWER(?)", "%#{query}%")
      .or(where("LOWER(diagnosis) LIKE LOWER(?)", "%#{query}%"))
      .or(where("LOWER(prescription) LIKE LOWER(?)", "%#{query}%"))
  end
end
