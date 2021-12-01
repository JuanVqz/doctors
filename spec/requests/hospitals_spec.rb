require "rails_helper"

RSpec.describe "Hospitals", type: :request do
  let(:hospital) { create :hospital, :basic }
  let(:doctor) do
    create :doctor, :admin, hospital_id: hospital.id
  end

  before :each do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe "GET /hospitals/1/edit" do
    it "hospitals edit" do
      get edit_hospital_path hospital
      expect(response).to have_http_status(200)
    end
  end
end
