class Appoinment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  has_many_attached :files, dependent: :destroy

  validates :reason, :prescription, :patient, presence: true
  validates :heart_rate, :breathing_rate, :temperature, :glycaemia, :sat_02,
    :cost, numericality: { greater_than_or_equal_to: 0 }

  after_save :update_patient

  scope :per_doctor, -> (doctor_id) { where(doctor_id: doctor_id) }
  scope :per_patient, -> (patient_id) { where(patient_id: patient_id) }
  scope :by_doctor_and_patient, -> (doctor_id, patient_id) { per_doctor(doctor_id).per_patient(patient_id) }

  def self.search query
    where("reason ILIKE ?", "%#{query}%")
      .or(where("note ILIKE ?", "%#{query}%"))
      .or(where("prescription ILIKE ?", "%#{query}%"))
  end

  private

  def update_patient
    self.patient.height = height
    self.patient.weight = weight
    self.patient.save
  end
end
