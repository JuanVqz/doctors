class User < ApplicationRecord
  default_scope { where(hospital_id: Hospital.current_id) }

  enum role: {patient: 0, doctor: 1, admin: 2}

  validates :role, presence: true

  devise :database_authenticatable, :registerable, :recoverable,
    :rememberable, :validatable, :confirmable, :trackable

  def active_for_authentication?
    super && active?
  end

  def to_s
    "#{name} #{first_name} #{last_name}".titleize
  end
end
