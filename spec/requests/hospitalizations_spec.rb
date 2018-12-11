require 'rails_helper'

RSpec.describe "Hospitalizations", type: :request do

  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }
  let(:patient) do
    create :patient, doctors: [doctor], hospital_id: hospital.id
  end
  let(:hospitalization) do
    create :hospitalization, doctor: doctor, patient: patient
  end

  before :each do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe "GET /hospitalizations" do
    it "List of hospitalizations" do
      get hospitalizations_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /hospitalizations/1" do
    it "hospitalization show" do
      get hospitalization_path hospitalization
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /hospitalizations/new" do
    it "hospitalization new" do
      get new_hospitalization_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /hospitalizations/1/edit" do
    it "hospitalization edit" do
      get edit_hospitalization_path hospitalization
      expect(response).to have_http_status(200)
    end
  end

end
