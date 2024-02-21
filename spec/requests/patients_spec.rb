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

  describe "DELETE /patients/1" do
    it "destroy a patient" do
      patient = create(:patient)

      expect {
        delete patient_path(patient)
      }.to change(Patient, :count).by(-1)
    end

    it "destroy patient's bentos" do
      patient = create(:patient, bentos: [build(:bento)])

      expect {
        delete patient_path(patient)
      }.to change(Bento, :count).by(-1)
    end

    xit "destroy patient's appoinments" do
      doctors = [doctor]
      appoinments = [build(:appoinment, doctor: doctor)]
      patient = create(:patient, appoinments: appoinments, doctors: doctors)

      expect {
        delete patient_path(patient)
      }.to change(Appoinment, :count).by(-1)
    end

    it "does not destroy patient's doctor" do
      patient = create(:patient, doctors: [doctor])

      expect {
        delete patient_path(patient)
      }.not_to change(Doctor, :count)
    end
  end
end
