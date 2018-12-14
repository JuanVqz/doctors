require 'rails_helper'

RSpec.describe HospitalsController, type: :controller do
  let(:hospital) do
    create :hospital, :basic, name: "Santa Ursula",
      subdomain: "santa"
  end
  let(:doctor) { create :doctor, :admin, hospital_id: hospital.id }
  let(:address) { attributes_for :address }

  let(:valid_attributes) do
    {
      name: "San Jóse",
      subdomain: "san_jose",
      address_attributes: address
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      subdomain: nil,
      address_attributes: address
    }
  end

  before :each do
    @request.host = "#{hospital.subdomain}.lvh.me"
    sign_in doctor
  end

  describe "GET #edit" do
    it "returns a success response" do
      hospital = Hospital.create! valid_attributes
      get :edit, params: { id: hospital.to_param }
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          name: "Santa Update",
          description: "Algo acerca de la página",
          address_attributes: address
        }
      end

      it "updates the requested hospital" do
        hospital = Hospital.create! valid_attributes
        put :update, params: { id: hospital.to_param, hospital: new_attributes }
        hospital.reload
        expect(hospital.name).to eq "Santa Update"
      end
    end

    context "with invalid params" do
      it "returns a success response to display the 'edit' template" do
        hospital = Hospital.create! valid_attributes
        put :update, params: { id: hospital.to_param, hospital: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
