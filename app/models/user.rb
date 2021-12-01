class User < ApplicationRecord
  default_scope { where(hospital_id: Hospital.current_id) }

  enum role: [:patient, :doctor, :admin]

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
