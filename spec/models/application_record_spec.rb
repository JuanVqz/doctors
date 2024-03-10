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

    context "with Appointment" do
      let(:appointment) { create(:appointment) }
      let(:appointment_old) { create(:appointment, created_at: 2.days.ago) }

      it "returns newest appointment first" do
        expect(Appointment.recent).to eq [appointment, appointment_old]
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
