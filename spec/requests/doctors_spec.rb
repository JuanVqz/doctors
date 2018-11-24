require 'rails_helper'

RSpec.describe "Doctors", type: :request do

  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id, role: "admin" }

  before :each do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    sign_in doctor
  end

  describe "GET /doctors" do
    it "List of doctors" do
      get doctors_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /doctors/1" do
    it "doctors show" do
      get doctor_path doctor
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /doctors/1/edit" do
    it "doctors edit" do
      get edit_doctor_path doctor
      expect(response).to have_http_status(200)
    end
  end

end
