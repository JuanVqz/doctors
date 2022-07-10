class Bento < ApplicationRecord
  belongs_to :patient

  validates :code, presence: true
  validates :code, uniqueness: true
end
