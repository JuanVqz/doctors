require 'rails_helper'

RSpec.describe Hospitalization, type: :model do
  it { should belong_to :doctor }
  it { should belong_to :patient }

  it { should validate_presence_of :patient_id }
  it { should validate_presence_of :starting }
  it { should validate_presence_of :ending }

  describe ".by_patient" do
    let(:hospital) { create :hospital }
    let(:doctor) { create :doctor, hospital: hospital }

    let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }
    let(:patient_other) { create :patient, doctors: [doctor], hospital_id: hospital.id }

    let(:hospitalization_other) do
      create :hospitalization, doctor: doctor, patient: patient_other, hospital_id: hospital.id
    end

    context "when Hospitalization belong to current doctor" do
      context "when Hospitalization belong to specific patient" do
        it "returns 3 hospitalizations" do
          allow(Hospital).to receive(:current_id).and_return hospital.id
          create_list :hospitalization, 3, doctor: doctor, patient: patient, hospital_id: hospital.id
          hospitalization_other

          expect(Hospitalization.by_patient(doctor.id, patient.id).count).to eq 3
        end
      end
    end
  end
end
