require "rails_helper"

RSpec.describe ApplicationRecord do
  describe ".recent" do
    context "order by created_at desc" do
      let(:hospitalization) { create(:hospitalization) }
      let(:hospitalization_old) { create(:hospitalization, created_at: 2.days.ago) }

      let(:appoinment) { create(:appoinment) }
      let(:appoinment_old) { create(:appoinment, created_at: 2.days.ago) }

      let(:patient) { create(:patient) }
      let(:patient_old) { create(:patient, created_at: 2.days.ago) }

      it "returns new hospitalization first" do
        expect(Hospitalization.recent).to eq [hospitalization, hospitalization_old]
      end

      it "returns new medical_consultation first" do
        expect(Appoinment.recent).to eq [appoinment, appoinment_old]
      end

      it "returns new patient first" do
        expect(Patient.recent).to eq [patient, patient_old]
      end
    end
  end
end
