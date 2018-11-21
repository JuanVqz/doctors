require "rails_helper"

RSpec.describe ApplicationRecord, type: :model do

  describe ".recent" do
    context "order by created_at desc" do
      let(:hospitalization) { create :hospitalization }
      let(:hospitalization_old) do
        create :hospitalization, created_at: 2.days.ago
      end

      let(:medical_consultation) { create :medical_consultation }
      let(:medical_consultation_old) do
        create :medical_consultation, created_at: 2.days.ago
      end

      let(:patient) { create :patient }
      let(:patient_old) { create :patient, created_at: 2.days.ago }

      it "returns new hospitalization first" do
        hospitalization
        hospitalization_old

        expect(Hospitalization.recent).to eq [hospitalization, hospitalization_old]
      end

      it "returns new medical_consultation first" do
        medical_consultation
        medical_consultation_old

        expect(MedicalConsultation.recent).to eq [medical_consultation, medical_consultation_old]
      end

      it "returns new patient first" do
        patient
        patient_old

        expect(Patient.recent).to eq [patient, patient_old]
      end
    end
  end

end
