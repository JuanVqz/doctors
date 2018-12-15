class Doctor < User
  belongs_to :hospital
  has_and_belongs_to_many :patients, join_table: "doctors_patients"
  has_many :medical_consultations, -> { order(created_at: :desc) }
  has_many :hospitalizations, -> { order(created_at: :desc) }

  validates :name, :first_name, :last_name, :specialty, presence: true

  delegate :subdomain, to: :hospital, prefix: true, allow_nil: true
end
