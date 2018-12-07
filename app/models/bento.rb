class Bento < ApplicationRecord
  belongs_to :patient

  validates :code, :patient, presence: true
  validates :code, uniqueness: true
end
