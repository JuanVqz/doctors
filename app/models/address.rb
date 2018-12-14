class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :state, presence: true

  def to_s
    "#{street} #{number} #{colony} \n #{postal_code} #{municipality} \n #{state} #{country}"
  end
end
