class MedicalConsultation < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :reason, :prescription, :patient_id, presence: true

  after_save :update_patient

  scope :per_doctor, -> (doctor_id) { where(doctor_id: doctor_id) }
  scope :per_patient, -> (patient_id) { where(patient_id: patient_id) }
  scope :by_doctor_and_patient, -> (doctor_id, patient_id) { per_doctor(doctor_id).per_patient(patient_id) }

  def self.search query
    where("reason ILIKE ?", "%#{query}%")
      .or(where("diagnosis ILIKE ?", "%#{query}%"))
      .or(where("prescription ILIKE ?", "%#{query}%"))
  end

  def update_patient
    self.patient.height = height
    self.patient.weight = weight
    self.patient.save
  end
end
