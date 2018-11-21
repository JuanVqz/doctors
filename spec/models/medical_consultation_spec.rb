require 'rails_helper'

RSpec.describe MedicalConsultation, type: :model do
  it { should belong_to :doctor }
  it { should belong_to :patient }

  it { should validate_presence_of :reason }
  it { should validate_presence_of :prescription }
  it { should validate_presence_of :patient_id }

  describe "returns medical_consultations" do
    let(:doctor_one) { create :doctor, name: "Pedro" }
    let(:doctor_two) { create :doctor, name: "José" }

    let(:patient_one) do
      create :patient, name: "Ramon", doctors: [doctor_one, doctor_two]
    end
    let(:patient_two) do
      create :patient, name: "Julian", doctors: [doctor_one, doctor_two]
    end

    let(:medical_consultations_doctor_one) do
      create_list :medical_consultation, 5, doctor: doctor_one, patient: patient_one
    end
    let(:medical_consultations_doctor_two) do
      create_list :medical_consultation, 3, doctor: doctor_two, patient: patient_two
    end

    before :each do
      medical_consultations_doctor_one
      medical_consultations_doctor_two
    end

    it ".per_doctor" do
      expect(MedicalConsultation.per_doctor(doctor_one.id).count).to eq 5
    end

    it ".per_patient" do
      expect(MedicalConsultation.per_patient(patient_one.id).count).to eq 5
    end

    it ".by_doctor_and_patient" do
      expect(MedicalConsultation.by_doctor_and_patient(doctor_one.id, patient_one.id).count).to eq 5
    end
  end

end
