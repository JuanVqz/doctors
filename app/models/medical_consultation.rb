class MedicalConsultation < ApplicationRecord
  default_scope { where(hospital_id: Hospital.current_id) }

  belongs_to :doctor
  belongs_to :patient

  validates :reason, :prescription, :patient_id, presence: true

  scope :by_patient, -> (doctor_id, patient_id) { where(doctor_id: doctor_id, patient_id: patient_id) }

end
