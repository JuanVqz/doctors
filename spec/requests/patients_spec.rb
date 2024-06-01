# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'patients', type: :request do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital:) }
  let(:patient) do
    create(:patient, doctors: [doctor], hospital:)
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe 'GET /patients' do
    it 'List of patients' do
      get patients_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /patients/1' do
    it 'patient show' do
      get patient_path patient
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /patients/new' do
    it 'patient new' do
      get new_patient_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /patients' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:patient) }
      let(:file) { fixture_file_upload('avatar.jpg', 'image/jpg') }

      it 'creates a new patient' do
        params = { patient: valid_attributes }
        expect do
          post patients_path, params:
        end.to change(Patient, :count).by(1)
      end

      it 'creates with avatar' do
        params = { patient: valid_attributes.merge(avatar: file) }
        expect do
          post patients_path, params:
        end.to change(Patient, :count).by(1)
                                      .and change(ActiveStorage::Attachment, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:patient, name: nil) }

      it 'does not create a new patient' do
        params = { patient: invalid_attributes }
        expect do
          post patients_path, params:
        end.not_to change(Patient, :count)
      end
    end
  end

  describe 'GET /patients/1/edit' do
    it 'patient edit' do
      get edit_patient_path patient
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /patients/1' do
    it 'destroy a patient' do
      patient = create(:patient)

      expect do
        delete patient_path(patient)
      end.to change(Patient, :count).by(-1)
    end

    it "destroy patient's address" do
      patient = create(:patient)

      expect do
        delete patient_path(patient)
      end.to change(Address, :count).by(-1)
    end

    it "destroy patient's appointments" do
      doctors = [doctor]
      appointments = [build(:appointment, doctor:)]
      patient = create(:patient, appointments:, doctors:)

      expect do
        delete patient_path(patient)
      end.to change(Appointment, :count).by(-1)
    end

    it "destroy patient's hospitalizations" do
      doctors = [doctor]
      patient = create(:patient, doctors:)
      create(:hospitalization, doctor:, patient:)

      expect do
        delete patient_path(patient)
      end.to change(Hospitalization, :count).by(-1)
    end

    it "does not destroy patient's doctor" do
      patient = create(:patient, doctors: [doctor])

      expect { delete patient_path(patient) }.not_to change(Doctor, :count)
    end
  end
end
