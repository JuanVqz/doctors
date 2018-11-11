require 'rails_helper'

RSpec.describe Hospitalization, type: :model do
  it { should belong_to :doctor }
  it { should belong_to :patient }

  it { should validate_presence_of :patient_id }
  it { should validate_presence_of :starting }
  it { should validate_presence_of :ending }
end
