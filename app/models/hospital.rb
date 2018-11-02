class Hospital < ApplicationRecord
  cattr_accessor :current_id

  validates :subdomain, uniqueness: true
end
