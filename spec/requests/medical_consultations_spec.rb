require 'rails_helper'

RSpec.describe "MedicalConsultations", type: :request do

  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }
  let(:patient) do
    create :patient, doctors: [doctor], hospital_id: hospital.id
  end
  let(:medical_consultation) do
    create :medical_consultation, doctor: doctor,
      patient: patient
  end

  before :each do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe "GET /medical_consultations" do
    it "List of medical consultations" do
      get medical_consultations_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /medical_consultations/1" do
    it "medical consultation show" do
      get medical_consultations_path medical_consultation
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /medical_consultations/new" do
    it "medical consultation new" do
      get new_medical_consultation_path patient
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /medical_consultations/1/edit" do
    it "medical consultation edit" do
      get edit_medical_consultation_path medical_consultation
      expect(response).to have_http_status(200)
    end
  end

end
