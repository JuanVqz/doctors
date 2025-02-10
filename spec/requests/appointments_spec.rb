# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'appointments', type: :request do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital:) }
  let(:patient) { create(:patient, doctors: [doctor], hospital:) }
  let(:appointment) { create(:appointment, doctor:, patient:) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    login_as doctor
  end

  describe 'GET /appointments' do
    it 'List of appointments' do
      get appointments_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /appointments/1' do
    it 'appointments show' do
      get appointments_path appointment
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /appointments/new' do
    it 'appointments new' do
      get new_appointment_path patient
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /appointments' do
    context 'with valid params' do
      let(:valid_attributes) { attributes_for(:appointment) }
      let(:file) { fixture_file_upload('patients.png', 'image/png') }

      it 'creates a new appointment' do
        params = { appointment: valid_attributes.merge(patient_id: patient.id) }
        expect do
          post appointments_path, params:
        end.to change(Appointment, :count).by(1)
      end

      it 'creates with files' do
        params = { appointment: valid_attributes.merge(patient_id: patient.id, files: [file]) }
        expect do
          post appointments_path, params:
        end.to change(Appointment, :count).by(1)
                                          .and change(ActiveStorage::Attachment, :count).by(1)
      end
    end

    context 'with invalid params' do
      let(:invalid_attributes) { attributes_for(:appointment, reason: nil) }

      it 'does not create a new appointment' do
        params = { appointment: invalid_attributes }
        expect do
          post appointments_path, params:
        end.to change(Appointment, :count).by(0)
      end
    end
  end

  describe 'GET /appointments/1/edit' do
    it 'appointments edit' do
      get edit_appointment_path appointment
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'DELETE /appointments/1' do
    it 'destroy an appointment' do
      appointment = create(:appointment)

      expect do
        delete appointment_path(appointment)
      end.to change(Appointment, :count).by(-1)
    end

    it 'destroy an appointment and files' do
      appointment = create(:appointment, :with_files)

      expect do
        delete appointment_path(appointment)
      end.to change { appointment.files.count }.from(2).to(0)
    end
  end
end
