require "rails_helper"

RSpec.describe ApplicationRecord do
  describe ".recent" do
    context "with Hospitalization" do
      let(:hospitalization) { create(:hospitalization) }
      let(:hospitalization_old) { create(:hospitalization, created_at: 2.days.ago) }

      it "returns newest hospitalization first" do
        expect(Hospitalization.recent).to eq [hospitalization, hospitalization_old]
      end
    end

    context "with Appoinment" do
      let(:appoinment) { create(:appoinment) }
      let(:appoinment_old) { create(:appoinment, created_at: 2.days.ago) }

      it "returns newest appoinment first" do
        expect(Appoinment.recent).to eq [appoinment, appoinment_old]
      end
    end

    context "with Patient" do
      let(:patient) { create(:patient) }
      let(:patient_old) { create(:patient, created_at: 2.days.ago) }

      it "returns newest patient first" do
        expect(Patient.recent).to eq [patient, patient_old]
      end
    end
  end
end
