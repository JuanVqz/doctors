require "rails_helper"

RSpec.describe "Appoinments" do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital_id: hospital.id) }
  let(:patient) do
    create(:patient, doctors: [doctor], hospital_id: hospital.id)
  end
  let(:appoinment) do
    create(:appoinment, doctor: doctor, patient: patient)
  end

  before do
    allow(Hospital).to receive(:current_id).and_return hospital.id
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
      let(:valid_attributes) do
        attributes_for(:appoinment)
      end

      it "creates a new appoinment" do
        params = {appoinment: valid_attributes.merge(patient_id: patient.id)}
        expect {
          post appoinments_path, params: params
        }.to change(Appoinment, :count).by(1)
      end
    end # context with valid params
  end # describe POST /appoinments

  describe "GET /appoinments/1/edit" do
    it "appoinments edit" do
      get edit_appoinment_path appoinment
      expect(response).to have_http_status(:ok)
    end
  end

  describe "DELETE /appoinments/1" do
    it "destroy an appoinment" do
      expect {
        delete appoinment_path(appoinment)
      }.not_to change(Appoinment, :count)
    end

    it "destroy an appoinment and files" do
      appoinment = create(:appoinment, :with_files)

      expect {
        delete appoinment_path(appoinment)
      }.to change { appoinment.files.count }.from(2).to(0)
    end
  end
end
