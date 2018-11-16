require 'rails_helper'

RSpec.describe MedicalConsultation, type: :model do
  it { should belong_to :doctor }
  it { should belong_to :patient }

  it { should validate_presence_of :reason }
  it { should validate_presence_of :prescription }
  it { should validate_presence_of :patient_id }

  describe ".by_patient" do
    let(:hospital) { create :hospital }
    let(:doctor) { create :doctor, hospital: hospital }

    let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }
    let(:patient_other) { create :patient, doctors: [doctor], hospital_id: hospital.id }

    let(:medical_consultation_other) do
      create :medical_consultation, doctor: doctor, patient: patient_other, hospital_id: hospital.id
    end

    context "when MedicalConsultation belong to current doctor" do
      context "when MedicalConsultation belong to specific patient" do
        it "returns 3 medical_consultations" do
          allow(Hospital).to receive(:current_id).and_return hospital.id
          create_list :medical_consultation, 3, doctor: doctor, patient: patient, hospital_id: hospital.id
          medical_consultation_other

          expect(MedicalConsultation.by_patient(doctor.id, patient.id).count).to eq 3
        end
      end
    end
  end
end
