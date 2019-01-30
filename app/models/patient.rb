class Patient < User
  has_one :clinic_history, dependent: :destroy
  has_one :address, as: :addressable, dependent: :destroy
  has_and_belongs_to_many :doctors, join_table: "doctors_patients"
  has_many :medical_consultations, -> { order(created_at: :desc) }
  has_many :hospitalizations, -> { order(created_at: :desc) }
  has_many :bentos

  accepts_nested_attributes_for :clinic_history, allow_destroy: true
  accepts_nested_attributes_for :address, allow_destroy: true

  validates :email, uniqueness: true, allow_nil: true
  validates :name, :first_name, :birthday, presence: true

  delegate :street, :number, :colony, :postal_code, :municipality,
    :state, :country, to: :address, prefix: true, allow_nil: true

  def self.search query
    where("concat_ws(' ', name, first_name, last_name) ILIKE ?", "%#{query&.squish}%")
  end

  def email_required?
    false
  end

  def password_required?
    false
  end
end
