class Patient < User
  validates :email, uniqueness: true, allow_nil: true
  has_and_belongs_to_many :doctors, join_table: "doctors_patients"

  validates :name, :first_name, :last_name, :birthday,
    :height, :weight, presence: true

  def email_required?
    false
  end

  def password_required?
    false
  end
end
