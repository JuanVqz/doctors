require 'rails_helper'

RSpec.describe HospitalizationsController, type: :controller do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  let(:valid_attributes) do
    {
      starting: "2018-11-10",
      ending: "2018-11-12",
      days_of_stay: 2,
      reason_for_hospitalization: "Razón de hospitalización",
      treatment: "Tratamiento",
      doctor_id: doctor.id,
      patient_id: patient.id
    }
  end

  let(:invalid_attributes) do
    {
      starting: nil,
      endign: "2018-11-12",
      days_of_stay: 2,
      reason_for_hospitalization: "Razón de hospitalización",
      treatment: "Tratamiento",
      doctor_id: doctor.id,
      patient_id: patient.id
    }
  end

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    @request.host = "#{hospital.subdomain}.lvh.me"
    sign_in doctor
  end

  describe "GET #index" do
    it "returns a success response" do
      Hospitalization.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      hospitalization = Hospitalization.create! valid_attributes
      get :show, params: { id: hospitalization.to_param }
      expect(response).to be_successful
    end

    it "returns a pdf file" do
      hospitalization = Hospitalization.create! valid_attributes
      get :show, params: { id: hospitalization.to_param, format: :pdf }
      expect(response.content_type).to eq "application/pdf"
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      hospitalization = Hospitalization.create! valid_attributes
      get :edit, params: { id: hospitalization.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Hospitalization" do
        expect {
          post :create, params: { hospitalization: valid_attributes }
        }.to change(Hospitalization, :count).by(1)
      end

      it "redirects to the created hospitalization" do
        post :create, params: { hospitalization: valid_attributes }
        expect(response).to redirect_to(Hospitalization.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { hospitalization: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          starting: "2018-11-10",
          ending: "2018-11-13",
          days_of_stay: 3,
          reason_for_hospitalization: "Razón de hospitalización",
          treatment: "Tratamiento",
          doctor_id: doctor.id,
          patient_id: patient.id
        }
      end

      it "updates the requested hospitalization" do
        hospitalization = Hospitalization.create! valid_attributes
        put :update, params: { id: hospitalization.to_param, hospitalization: new_attributes }
        hospitalization.reload
        expect(hospitalization.ending.strftime("%F")).to eq "2018-11-13"
      end

      it "redirects to the hospitalization" do
        hospitalization = Hospitalization.create! valid_attributes
        put :update, params: { id: hospitalization.to_param, hospitalization: valid_attributes }
        expect(response).to redirect_to(hospitalization)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        hospitalization = Hospitalization.create! valid_attributes
        put :update, params: { id: hospitalization.to_param, hospitalization: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested hospitalization" do
      hospitalization = Hospitalization.create! valid_attributes
      expect {
        delete :destroy, params: { id: hospitalization.to_param }
      }.to change(Hospitalization, :count).by(-1)
    end

    it "redirects to the hospitalizations list" do
      hospitalization = Hospitalization.create! valid_attributes
      delete :destroy, params: { id: hospitalization.to_param }
      expect(response).to redirect_to(hospitalizations_url)
    end
  end

end
