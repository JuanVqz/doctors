require 'rails_helper'

RSpec.describe MedicalConsultation, type: :model do
  it { should belong_to :doctor }
  it { should belong_to :patient }

  it { should validate_presence_of :reason }
  it { should validate_presence_of :prescription }
  it { should validate_presence_of :patient_id }
end
