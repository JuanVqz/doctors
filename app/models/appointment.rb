class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient
  belongs_to :hospital

  has_many_attached :files, dependent: :destroy

  validates :reason, :prescription, :doctor, :patient, :hospital, presence: true
  validates :heart_rate, :breathing_rate, :temperature, :glycaemia, :sat_02, :cost, numericality: {greater_than_or_equal_to: 0}

  after_save :update_patient

  def self.search query
    where("reason ILIKE ?", "%#{query}%")
      .or(where("note ILIKE ?", "%#{query}%"))
      .or(where("prescription ILIKE ?", "%#{query}%"))
  end

  private

  def update_patient
    patient.height = height
    patient.weight = weight
    patient.save
  end
end
