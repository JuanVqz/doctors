class Hospitalization < ApplicationRecord
  default_scope { where(hospital_id: Hospital.current_id) }

  belongs_to :doctor
  belongs_to :patient

  validates :starting, :ending, :patient_id, presence: true
end
