class Patient < User
  has_one :clinic_history, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy
  has_and_belongs_to_many :doctors, join_table: "doctors_patients"
  has_many :medical_consultations
  has_many :hospitalizations

  accepts_nested_attributes_for :clinic_history, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true

  validates :email, uniqueness: true, allow_nil: true
  validates :name, :first_name, :birthday,
    :height, :weight, presence: true

  delegate :street, :number, :colony, :postal_code, :municipality,
    :state, :country, to: :address, prefix: true, allow_nil: true

  def email_required?
    false
  end

  def password_required?
    false
  end
end
