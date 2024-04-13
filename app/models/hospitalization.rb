class Hospitalization < ApplicationRecord
  enum status: {"Alta m\u00E9dica" => 0, "Alta voluntaria" => 1, "Traslado a otra unidad" => 2}

  belongs_to :hospital
  belongs_to :doctor
  belongs_to :patient
  belongs_to :referred_doctor

  validates :starting, :ending, :days_of_stay, :hospital, :patient, :doctor, :referred_doctor, :status, presence: true
  validates :days_of_stay, numericality: {greater_than: 0}

  def self.search query
    where("reason_for_hospitalization ILIKE ?", "%#{query}%")
      .or(where("treatment ILIKE ?", "%#{query}%"))
  end
end
