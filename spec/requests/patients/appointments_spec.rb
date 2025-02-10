# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'patients/appointments', type: :request do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital:) }
  let(:patient) { create(:patient, doctors: [doctor], hospital:) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    login_as doctor
  end

  describe 'GET /patients/1/appointments' do
    it "returns patient's appointment history" do
      get patient_appointments_path(patient_id: patient.id)
      expect(response).to have_http_status(:ok)
    end
  end
end
