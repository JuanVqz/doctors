# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'patient_referrals', type: :request do
  let(:hospital) { create(:hospital) }
  let(:valid_attributes) do
    {
      subject: 'Subject',
      content: 'Content',
      patient_id: patient.id,
      doctor_id: doctor.id,
      referred_doctor_id: referred_doctor.id,
      hospital_id: hospital.id
    }
  end
  let(:invalid_attributes) do
    {
      subject: '',
      content: '',
      importance: 'electivo',
      patient_id: nil,
      referred_doctor_id: nil,
      hospital_id: nil
    }
  end
  let(:doctor) { create(:doctor, hospital:) }
  let(:patient) { create(:patient, doctors: [doctor]) }
  let(:referred_doctor) { create(:referred_doctor, doctor:) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    login_as doctor
  end

  describe 'GET /index' do
    it 'renders a successful response' do
      PatientReferral.create! valid_attributes
      get patient_referrals_url
      expect(response).to be_successful
    end
  end

  describe 'GET /show' do
    it 'renders a successful response' do
      patient_referral = PatientReferral.create! valid_attributes
      get patient_referral_url(patient_referral)
      expect(response).to be_successful
    end
  end

  describe 'GET /new' do
    it 'renders a successful response' do
      get new_patient_referral_url
      expect(response).to be_successful
    end
  end

  describe 'GET /edit' do
    it 'render a successful response' do
      patient_referral = PatientReferral.create! valid_attributes
      get edit_patient_referral_url(patient_referral)
      expect(response).to be_successful
    end
  end

  describe 'POST /create' do
    context 'with valid parameters' do
      it 'creates a new PatientReferral' do
        expect do
          post patient_referrals_url, params: { patient_referral: valid_attributes }
        end.to change(PatientReferral, :count).by(1)
      end

      it 'redirects to the created patient_referral' do
        post patient_referrals_url, params: { patient_referral: valid_attributes }
        expect(response).to redirect_to(patient_referral_url(PatientReferral.last))
      end
    end

    context 'with invalid parameters' do
      it 'does not create a new PatientReferral' do
        expect do
          post patient_referrals_url, params: { patient_referral: invalid_attributes }
        end.not_to change(PatientReferral, :count)
      end

      it 'returns an unprocessable entry' do
        post patient_referrals_url, params: { patient_referral: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'PATCH /update' do
    context 'with valid parameters' do
      let(:new_attributes) do
        {
          subject: 'New Subject'
        }
      end

      it 'updates the requested patient_referral' do
        patient_referral = PatientReferral.create! valid_attributes
        patch patient_referral_url(patient_referral), params: { patient_referral: new_attributes }
        patient_referral.reload
        expect(patient_referral.subject).to eq 'New Subject'
      end

      it 'redirects to the patient_referral' do
        patient_referral = PatientReferral.create! valid_attributes
        patch patient_referral_url(patient_referral), params: { patient_referral: new_attributes }
        patient_referral.reload
        expect(response).to redirect_to(patient_referral_url(patient_referral))
      end
    end

    context 'with invalid parameters' do
      it 'returns an unprocessable entry' do
        patient_referral = PatientReferral.create! valid_attributes
        patch patient_referral_url(patient_referral), params: { patient_referral: invalid_attributes }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe 'DELETE /destroy' do
    it 'destroys the requested patient_referral' do
      patient_referral = PatientReferral.create! valid_attributes
      expect do
        delete patient_referral_url(patient_referral)
      end.to change(PatientReferral, :count).by(-1)
    end

    it 'redirects to the patient_referrals list' do
      patient_referral = PatientReferral.create! valid_attributes
      delete patient_referral_url(patient_referral)
      expect(response).to redirect_to(patient_referrals_url)
    end
  end
end
