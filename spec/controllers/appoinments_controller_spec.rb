require 'rails_helper'

RSpec.describe AppoinmentsController, type: :controller do

  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  let(:valid_attributes) do
    {
      reason: "Motivo de la consulta",
      note: "Objetive, Plan, Diagnosis, Treatment",
      prescription: "Cloroformo por 3 días, Otra cosa",
      recommendations: "Resultados del laboratorio",
      doctor_id: doctor.id,
      patient_id: patient.id,
      imc: 27.34375,
      weight: 80.0,
      height: 175.0,
      blood_pressure: "No se que es",
      heart_rate: 0,
      breathing_rate: 0,
      temperature: 0,
      glycaemia: 0,
      sat_02: 0,
      cost: 0,
      cabinet_results: "Resultados del laboratorio",
      histopathology: "No se que es"
    }
  end

  let(:invalid_attributes) do
    {
      reason: nil,
      note: "Objetive, Plan, Diagnosis, Treatment",
      prescription: "Cloroformo por 3 días, Otra cosa",
      recommendations: "Resultados del laboratorio",
      doctor_id: doctor.id,
      patient_id: patient.id,
      imc: 27.34375,
      weight: 80.0,
      height: 175.0,
      blood_group: "No se que es",
      heart_rate: -1,
      breathing_rate: -1,
      temperature: -1,
      glycaemia: -1,
      sat_02: -1,
      cost: -1,
      cabinet_results: "Resultados del laboratorio",
      histopathology: "No se que es"
    }
  end

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    @request.host = "#{hospital.subdomain}.lvh.me"
    sign_in doctor
  end

  describe "GET #index" do
    it "returns a success response" do
      Appoinment.create! valid_attributes
      get :index
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      appoinment = Appoinment.create! valid_attributes
      get :show, params: {id: appoinment.to_param}
      expect(response).to be_successful
    end
  end

  describe "GET #new" do
    it "returns a success response" do
      get :new
      expect(response).to be_successful
    end
  end

  describe "GET #edit" do
    it "returns a success response" do
      appoinment = Appoinment.create! valid_attributes
      get :edit, params: {id: appoinment.to_param}
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Appoinment" do
        expect {
          post :create, params: {appoinment: valid_attributes}
        }.to change(Appoinment, :count).by(1)
      end

      it "redirects to the created appoinment" do
        post :create, params: {appoinment: valid_attributes}
        expect(response).to redirect_to(Appoinment.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: {appoinment: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          reason: "Motivo de la consulta actualizada",
          note: "Objetive, Plan, Diagnosis, Treatment",
          prescription: "Cloroformo por 3 días, Otra cosa",
          recommendations: "Resultados del laboratorio",
          doctor_id: doctor.id,
          patient_id: patient.id,
          imc: 27.34375,
          weight: 80.0,
          height: 175.0,
          blood_group: "No se que es",
          heart_rate: 0,
          breathing_rate: 0,
          temperature: 0,
          glycaemia: 0,
          sat_02: 0,
          cost: 0,
          cabinet_results: "Resultados del laboratorio",
          histopathology: "No se que es"
        }
      end

      it "updates the requested appoinment" do
        appoinment = Appoinment.create! valid_attributes
        put :update, params: {id: appoinment.to_param, appoinment: new_attributes}
        appoinment.reload
        expect(appoinment.reason).to eq "Motivo de la consulta actualizada"
      end

      it "redirects to the appoinment" do
        appoinment = Appoinment.create! valid_attributes
        put :update, params: {id: appoinment.to_param, appoinment: valid_attributes}
        expect(response).to redirect_to(appoinment)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        appoinment = Appoinment.create! valid_attributes
        put :update, params: {id: appoinment.to_param, appoinment: invalid_attributes}
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested appoinment" do
      appoinment = Appoinment.create! valid_attributes
      expect {
        delete :destroy, params: {id: appoinment.to_param}
      }.to change(Appoinment, :count).by(-1)
    end

    it "redirects to the appoinments list" do
      appoinment = Appoinment.create! valid_attributes
      delete :destroy, params: {id: appoinment.to_param}
      expect(response).to redirect_to(appoinments_url)
    end
  end

end
