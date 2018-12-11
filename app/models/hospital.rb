class Hospital < ApplicationRecord
  cattr_accessor :current_id

  enum plan: [:basic, :medium]

  validates :subdomain, :name, presence: true
  validates :subdomain, :name, uniqueness: true

  def to_s
    name.titleize
  end
end
