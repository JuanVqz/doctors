class Doctor < User
  belongs_to :hospital

  validates :name, :first_name, :last_name, :specialty, presence: true

  def to_s
    "#{name} #{first_name} #{last_name}".titleize
  end
end
