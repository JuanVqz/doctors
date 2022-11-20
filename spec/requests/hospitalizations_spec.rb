require "rails_helper"

RSpec.describe "Hospitalizations" do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital_id: hospital.id) }
  let(:patient) do
    create(:patient, doctors: [doctor], hospital_id: hospital.id)
  end
  let(:referred_doctor) { create(:referred_doctor, doctor: doctor) }
  let(:hospitalization) do
    create(:hospitalization, doctor: doctor, patient: patient)
  end

  before do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    allow_any_instance_of(ApplicationController).to receive(:current_hospital)
      .and_return hospital
    sign_in doctor
  end

  describe "GET /hospitalizations" do
    it "List of hospitalizations" do
      get hospitalizations_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /hospitalizations/1" do
    it "hospitalization show" do
      get hospitalization_path hospitalization
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /hospitalizations/new" do
    it "hospitalization new" do
      get new_hospitalization_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /hospitalizations" do
    let(:hospitalization_params) do
      attributes_for(:hospitalization)
        .merge(doctor_id: doctor.id,
          patient_id: patient.id,
          referred_doctor_id: referred_doctor.id)
    end

    it "creates a new Hospitalization with ReferredDoctor" do
      post hospitalizations_path, params: {hospitalization: hospitalization_params}

      expect(Hospitalization.last.status).to eq "Alta voluntaria"
      expect(Hospitalization.last.referred_doctor_id).to eq referred_doctor.id
    end
  end # describe POST /hospitalizations

  describe "GET /hospitalizations/1/edit" do
    it "hospitalization edit" do
      get edit_hospitalization_path hospitalization
      expect(response).to have_http_status(:ok)
    end
  end
end
