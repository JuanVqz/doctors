require "rails_helper"

RSpec.describe "appoinments", type: :request do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital: hospital) }
  let(:patient) do
    create(:patient, doctors: [doctor], hospital: hospital)
  end
  let(:appoinment) do
    create(:appoinment, doctor: doctor, patient: patient)
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe "GET /appoinments" do
    it "List of appoinments" do
      get appoinments_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /appoinments/1" do
    it "appoinments show" do
      get appoinments_path appoinment
      expect(response).to have_http_status(:ok)
    end
  end

  describe "GET /appoinments/new" do
    it "appoinments new" do
      get new_appoinment_path patient
      expect(response).to have_http_status(:ok)
    end
  end

  describe "POST /appoinments" do
    context "with valid params" do
      let(:valid_attributes) { attributes_for(:appoinment) }
      let(:file) { fixture_file_upload("patients.png", "image/png") }

      it "creates a new appoinment" do
        params = {appoinment: valid_attributes.merge(patient_id: patient.id)}
        expect {
          post appoinments_path, params: params
        }.to change(Appoinment, :count).by(1)
      end

      it "creates with files" do
        params = {appoinment: valid_attributes.merge(patient_id: patient.id, files: [file])}
        expect {
          post appoinments_path, params: params
        }.to change(Appoinment, :count).by(1)
          .and change(ActiveStorage::Attachment, :count).by(1)
      end
    end

    context "with invalid params" do
      let(:invalid_attributes) { attributes_for(:appoinment, reason: nil) }

      it "does not create a new appoinment" do
        params = {appoinment: invalid_attributes}
        expect {
          post appoinments_path, params: params
        }.to change(Appoinment, :count).by(0)
      end
    end
  end

  describe "GET /appoinments/1/edit" do
    it "appoinments edit" do
      get edit_appoinment_path appoinment
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /appoinments/1" do
    it "destroy an appoinment" do
      appoinment = create(:appoinment)

      expect {
        delete appoinment_path(appoinment)
      }.to change(Appoinment, :count).by(-1)
    end

    it "destroy an appoinment and files" do
      appoinment = create(:appoinment, :with_files)

      expect {
        delete appoinment_path(appoinment)
      }.to change { appoinment.files.count }.from(2).to(0)
    end
  end
end
