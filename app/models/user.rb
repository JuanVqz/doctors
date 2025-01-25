# frozen_string_literal: true

class User < ApplicationRecord
  belongs_to :hospital

  enum :role, %i[patient doctor admin], validate: true

  validates :role, :hospital, presence: true

  devise :database_authenticatable, :recoverable, :rememberable, :validatable, :confirmable, :trackable

  def active_for_authentication?
    super && active?
  end

  def to_s
    "#{name} #{first_name} #{last_name}".titleize
  end
end
