require "rails_helper"

RSpec.describe "referred_doctors", type: :request do
  let(:hospital) { create(:hospital, :basic) }
  let(:valid_attributes) do
    {
      full_name: "Licha Perez",
      specialty: "Odontólogo General",
      phone_number: "5551111111",
      doctor: doctor,
      hospital: hospital,
      address_attributes: {
        street: "Independencia",
        number: "19",
        state: "Oaxaca"
      }
    }
  end
  let(:invalid_attributes) do
    {
      full_name: nil,
      specialty: nil,
      doctor: nil
    }
  end
  let(:doctor) { create(:doctor, :admin, hospital: hospital) }

  before do
    allow_any_instance_of(ApplicationController).to receive(:current_hospital).and_return hospital
    sign_in doctor
  end

  describe "GET /index" do
    it "renders a successful response" do
      ReferredDoctor.create! valid_attributes
      get referred_doctors_url
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      referred_doctor = ReferredDoctor.create! valid_attributes
      get referred_doctor_url(referred_doctor)
      expect(response).to be_successful
    end
  end

  describe "GET /new" do
    it "renders a successful response" do
      get new_referred_doctor_url
      expect(response).to be_successful
    end
  end

  describe "GET /edit" do
    it "render a successful response" do
      referred_doctor = ReferredDoctor.create! valid_attributes
      get edit_referred_doctor_url(referred_doctor)
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ReferredDoctor" do
        expect do
          post referred_doctors_url, params: {referred_doctor: valid_attributes}
        end.to change(ReferredDoctor, :count).by(1)
          .and change(Address, :count).by(1)
      end

      it "redirects to the created referred_doctor" do
        post referred_doctors_url, params: {referred_doctor: valid_attributes}
        expect(response).to redirect_to(referred_doctor_url(ReferredDoctor.last))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ReferredDoctor" do
        expect do
          post referred_doctors_url, params: {referred_doctor: invalid_attributes}
        end.not_to change(ReferredDoctor, :count)
      end

      it "returns an unprocessable entry" do
        post referred_doctors_url, params: {referred_doctor: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) do
        {
          full_name: "Licha Vazquez"
        }
      end

      it "updates the requested referred_doctor" do
        referred_doctor = ReferredDoctor.create! valid_attributes
        patch referred_doctor_url(referred_doctor), params: {referred_doctor: new_attributes}
        referred_doctor.reload
        expect(referred_doctor.full_name).to eq "Licha Vazquez"
      end

      it "redirects to the referred_doctor" do
        referred_doctor = ReferredDoctor.create! valid_attributes
        patch referred_doctor_url(referred_doctor), params: {referred_doctor: new_attributes}
        referred_doctor.reload
        expect(response).to redirect_to(referred_doctor_url(referred_doctor))
      end
    end

    context "with invalid parameters" do
      it "returns an unprocessable entry" do
        referred_doctor = ReferredDoctor.create! valid_attributes
        patch referred_doctor_url(referred_doctor), params: {referred_doctor: invalid_attributes}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested referred_doctor" do
      referred_doctor = ReferredDoctor.create! valid_attributes
      expect {
        delete referred_doctor_url(referred_doctor)
      }.to change(ReferredDoctor, :count).by(-1)
    end

    it "redirects to the referred_doctors list" do
      referred_doctor = ReferredDoctor.create! valid_attributes
      delete referred_doctor_url(referred_doctor)
      expect(response).to redirect_to(referred_doctors_url)
    end
  end
end
