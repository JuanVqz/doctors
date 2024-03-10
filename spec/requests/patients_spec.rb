require "rails_helper"

RSpec.describe "patients", type: :request do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital: hospital) }
  let(:patient) do
    create(:patient, doctors: [doctor], hospital: hospital)
  end

  before do
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

  describe "POST /patients" do
    context "with valid params" do
      let(:valid_attributes) { attributes_for(:patient) }
      let(:file) { fixture_file_upload("avatar.jpg", "image/jpg") }

      it "creates a new patient" do
        params = {patient: valid_attributes}
        expect {
          post patients_path, params: params
        }.to change(Patient, :count).by(1)
      end

      it "creates with avatar" do
        params = {patient: valid_attributes.merge(avatar: file)}
        expect {
          post patients_path, params: params
        }.to change(Patient, :count).by(1)
          .and change(ActiveStorage::Attachment, :count).by(1)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { attributes_for(:patient, name: nil) }

      it "does not create a new patient" do
        params = {patient: invalid_attributes}
        expect {
          post patients_path, params: params
        }.not_to change(Patient, :count)
      end
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

    xit "destroy patient's appointments" do
      doctors = [doctor]
      appointments = [build(:appointment, doctor: doctor)]
      patient = create(:patient, appointments: appointments, doctors: doctors)

      expect {
        delete patient_path(patient)
      }.to change(Appointment, :count).by(-1)
    end

    it "does not destroy patient's doctor" do
      patient = create(:patient, doctors: [doctor])

      expect {
        delete patient_path(patient)
      }.not_to change(Doctor, :count)
    end
  end
end
