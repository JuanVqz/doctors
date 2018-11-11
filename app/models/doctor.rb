class Doctor < User
  belongs_to :hospital
  has_and_belongs_to_many :patients, join_table: "doctors_patients"
  has_many :medical_consultations
  has_many :hospitalizations

  validates :name, :first_name, :last_name, :specialty, presence: true
end
