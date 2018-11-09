class Doctor < User
  belongs_to :hospital
  has_many :medical_consultations
  has_and_belongs_to_many :patients, join_table: "doctors_patients"

  validates :name, :first_name, :last_name, :specialty, presence: true
end
