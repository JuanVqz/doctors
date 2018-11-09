class Hospital < ApplicationRecord
  cattr_accessor :current_id

  validates :subdomain, uniqueness: true

  def to_s
    name.titleize
  end
end
