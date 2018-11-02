class User < ApplicationRecord
  default_scope { where(hospital_id: Hospital.current_id) }

  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :validatable, :confirmable, :trackable

  def active_for_authentication?
    super && active?
  end
end
