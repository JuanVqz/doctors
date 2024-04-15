# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'hospitals', type: :request do
  let(:hospital) { create(:hospital, :basic) }
  let(:doctor) do
    create(:doctor, :admin, hospital_id: hospital.id)
  end

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe 'GET /hospitals/1/edit' do
    it 'hospitals edit' do
      get edit_hospital_path hospital
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'PUT /hospitals/1' do
    context 'with valid parameters' do
      let(:valid_params) { attributes_for(:hospital) }

      it 'updates the requested hospital' do
        put hospital_path(hospital), params: { hospital: valid_params }
        expect(response).to redirect_to(edit_hospital_path(hospital))
      end
    end

    context 'with invalid parameters' do
      let(:invalid_params) { attributes_for(:hospital, name: '') }

      it 'does not update the requested hospital' do
        put hospital_path(hospital), params: { hospital: invalid_params }
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end
