# frozen_string_literal: true

class Address < ApplicationRecord
  belongs_to :addressable, polymorphic: true

  validates :state, presence: true

  def to_s
    "#{street} #{number}\n#{colony}\n#{postal_code} #{municipality}"
  end
end
