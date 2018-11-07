require 'rails_helper'

RSpec.describe "Doctors", type: :request do

  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  before :each do
    sign_in doctor
  end

  describe "GET /doctors" do
    it "List of doctors" do
      get doctors_path
      expect(response).to have_http_status(200)
    end
  end
end
