require 'rails_helper'

RSpec.describe Hospitalization, type: :model do

  it { should belong_to :doctor }
  it { should belong_to :patient }

  it { should validate_presence_of :patient_id }
  it { should validate_presence_of :starting }
  it { should validate_presence_of :ending }

  describe "returns hospitalizations" do
    let(:doctor_one) { create :doctor, name: "Pedro" }
    let(:doctor_two) { create :doctor, name: "José" }

    let(:patient_one) do
      create :patient, name: "Ramon", doctors: [doctor_one, doctor_two]
    end
    let(:patient_two) do
      create :patient, name: "Julian", doctors: [doctor_one, doctor_two]
    end

    let(:hospitalizations_one) do
      create_list :hospitalization, 5, doctor: doctor_one, patient: patient_one
    end
    let(:hospitalization_two) do
      create_list :hospitalization, 3, doctor: doctor_two, patient: patient_two
    end

    before :each do
      hospitalizations_one
      hospitalization_two
    end

    it ".per_doctor" do
      expect(Hospitalization.per_doctor(doctor_one.id).count).to eq 5
    end

    it ".per_patient" do
      expect(Hospitalization.per_patient(patient_one.id).count).to eq 5
    end

    it ".by_doctor_and_patient" do
      expect(Hospitalization.by_doctor_and_patient(doctor_one.id, patient_one.id).count).to eq 5
    end
  end

end
