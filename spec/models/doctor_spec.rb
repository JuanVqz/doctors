require "rails_helper"

RSpec.describe Doctor, type: :model do
  it { should belong_to :hospital }
  it { should have_and_belong_to_many :patients }
  it { should have_many :medical_consultations }
  it { should have_many :hospitalizations }

  it { should validate_presence_of :name }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :specialty }
end
