# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'hospitalizations', type: :request do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital:) }
  let(:patient) do
    create(:patient, doctors: [doctor], hospital:)
  end
  let(:referred_doctor) { create(:referred_doctor, doctor:) }
  let(:hospitalization) do
    create(:hospitalization, doctor:, patient:)
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    login_as doctor
  end

  describe 'GET /hospitalizations' do
    it 'List of hospitalizations' do
      get hospitalizations_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /hospitalizations/1' do
    it 'hospitalization show' do
      get hospitalization_path hospitalization
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'GET /hospitalizations/new' do
    it 'hospitalization new' do
      get new_hospitalization_path
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST /hospitalizations' do
    let(:hospitalization_params) do
      attributes_for(:hospitalization)
        .merge(patient_id: patient.id, hospital_id: hospital.id, referred_doctor_id: referred_doctor.id)
    end

    it 'creates a new Hospitalization with ReferredDoctor' do
      post hospitalizations_path, params: { hospitalization: hospitalization_params }

      expect(Hospitalization.last.status).to eq 'Alta voluntaria'
      expect(Hospitalization.last.referred_doctor_id).to eq referred_doctor.id
    end
  end

  describe 'GET /hospitalizations/1/edit' do
    it 'hospitalization edit' do
      get edit_hospitalization_path hospitalization
      expect(response).to have_http_status(:ok)
    end
  end
end
