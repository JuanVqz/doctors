require 'rails_helper'

RSpec.describe "MedicalConsultations", type: :request do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  before :each do
    sign_in doctor
  end

  describe "GET /medical_consultations" do
    it "List of medical consultations" do
      get medical_consultations_path
      expect(response).to have_http_status(200)
    end
  end
end
