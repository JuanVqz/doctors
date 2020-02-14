require 'rails_helper'

RSpec.describe "Appoinments", type: :request do

  let(:hospital) { create :hospital, :basic }
  let(:doctor) { create :doctor, hospital_id: hospital.id }
  let(:patient) do
    create :patient, doctors: [doctor], hospital_id: hospital.id
  end
  let(:appoinment) do
    create :appoinment, doctor: doctor, patient: patient
  end

  before :each do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe "GET /appoinments" do
    it "List of appoinments" do
      get appoinments_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /appoinments/1" do
    it "appoinments show" do
      get appoinments_path appoinment
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /appoinments/new" do
    it "appoinments new" do
      get new_appoinment_path patient
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /appoinments/1/edit" do
    it "appoinments edit" do
      get edit_appoinment_path appoinment
      expect(response).to have_http_status(200)
    end
  end

end
