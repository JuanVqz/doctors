require "rails_helper"

RSpec.describe "patients/appoinments", type: :request do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital: hospital) }
  let(:patient) do
    create(:patient, doctors: [doctor], hospital: hospital)
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe "GET /patients/1/appoinments" do
    it "returns patient's appoinment history" do
      get patient_appoinments_path(patient_id: patient.id)
      expect(response).to have_http_status(:ok)
    end
  end
end
