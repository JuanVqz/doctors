require "rails_helper"

RSpec.describe "Patient" do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital_id: hospital.id) }
  let(:patient) do
    create(:patient, doctors: [doctor], hospital_id: hospital.id)
  end

  before do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe "GET /patients" do
    it "List of patients" do
      get patients_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /patients/1" do
    it "patient show" do
      get patient_path patient
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /patients/new" do
    it "patient new" do
      get new_patient_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /patients/1/edit" do
    it "patient edit" do
      get edit_patient_path patient
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /patients/1/appoinments" do
    it "returns patient's appoinments" do
      get appoinments_patient_path(patient), xhr: true
      expect(response).to have_http_status(:ok)
    end
  end
end
