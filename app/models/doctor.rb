class Doctor < User
  belongs_to :hospital
  has_and_belongs_to_many :patients, join_table: "doctors_patients"
  has_many :medical_consultations
  has_many :appoinments
  has_many :hospitalizations, -> { order(created_at: :desc) }
  has_many :referred_doctors

  validates :name, :first_name, :last_name, :specialty, presence: true
  validate :role_error_message, if: :role_is_patient?

  delegate :subdomain, to: :hospital, prefix: true, allow_nil: true

  def role_is_patient?
    patient?
  end

  def role_error_message
    errors.add(:role, "no puede tener el rol paciente")
  end
end
