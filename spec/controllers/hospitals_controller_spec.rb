require 'rails_helper'

RSpec.describe HospitalsController, type: :controller do
  let(:hospital) do
    create :hospital, :basic, name: "Santa Ursula",
      subdomain: "santa"
  end
  let(:doctor) { create :doctor, :admin, hospital_id: hospital.id }

  let(:invalid_attributes) do
    {
      name: nil
    }
  end

  before :each do
    @request.host = "#{hospital.subdomain}.lvh.me"
    sign_in doctor
  end

  describe "GET #edit" do
    it "returns a success response" do
      get :edit, params: { id: hospital.id }
      expect(response).to be_successful
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          name: "Santa Update",
          description: "Algo acerca de la página",
        }
      end

      it "updates the requested hospital" do
        put :update, params: { id: hospital.id, hospital: new_attributes }
        hospital.reload
        expect(hospital.name).to eq "Santa Update"
      end
    end

    context "with invalid params" do
      it "returns a success response to display the 'edit' template" do
        put :update, params: { id: hospital.id, hospital: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
