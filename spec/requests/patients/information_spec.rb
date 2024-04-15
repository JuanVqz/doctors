# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'patients/information', type: :request do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) { create(:doctor, hospital:) }
  let(:patient) { create(:patient, doctors: [doctor], hospital:) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe 'GET /patients/1/information' do
    it "returns patient's information" do
      create_list(:appointment, 3, patient:, doctor:)

      get patient_information_index_path(patient_id: patient.id, format: :turbo_stream)
      expect(response).to have_http_status(:ok)
    end
  end
end
