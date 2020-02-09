require 'rails_helper'

RSpec.describe MedicalConsultationsController, type: :controller do

  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:patient) { create :patient, doctors: [doctor], hospital_id: hospital.id }

  let(:valid_attributes) do
    {
      reason: "Motivo de la consulta",
      subjetive: "Que hay que hacer",
      objetive: "Que se debe hacer",
      plan: "Como se debe hacer",
      diagnosis: "Como se soluciona",
      treatment: "Con que medicamento se curará",
      observations: "Algo que decir",
      prescription: "Cloroformo por 3 días, Otra cosa",
      lab_results: "Resultados del laboratorio",
      histopathology: "No se que es",
      comments: "Algo que decir con respecto al resutaldo de laboratorio",
      height: 175.0,
      weight: 80.0,
      imc: 27.34375,
      doctor_id: doctor.id,
      patient_id: patient.id,
      heart_rate: 0,
      breathing_rate: 0,
      temperature: 0,
      glycaemia: 0,
      sat_02: 0,
      cost: 0
    }
  end

  let(:invalid_attributes) do
    {
      reason: nil,
      subjetive: "Que hay que hacer",
      objetive: "Que se debe hacer",
      plan: "Como se debe hacer",
      diagnosis: "Como se soluciona",
      treatment: "Con que medicamento se curará",
      observations: "Algo que decir",
      prescription: "Cloroformo por 3 días, Otra cosa",
      lab_results: "Resultados del laboratorio",
      histopathology: "No se que es",
      comments: "Algo que decir con respecto al resutaldo de laboratorio",
      height: 175.0,
      weight: 80.0,
      imc: 27.34375,
      doctor_id: doctor.id,
      patient_id: patient.id,
      heart_rate: -1,
      breathing_rate: -1,
      temperature: -1,
      glycaemia: -1,
      sat_02: -1,
      cost: -1
    }
  end

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    @request.host = "#{hospital.subdomain}.lvh.me"
    sign_in doctor
  end

  describe "GET #index" do
    it "returns a success response" do
      MedicalConsultation.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      medical_consultation = MedicalConsultation.create! valid_attributes
      get :show, params: { id: medical_consultation.to_param }
      expect(response).to be_successful
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
      medical_consultation = MedicalConsultation.create! valid_attributes
      get :edit, params: { id: medical_consultation.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new MedicalConsultation" do
        expect {
          post :create, params: { medical_consultation: valid_attributes }
        }.to change(MedicalConsultation, :count).by(1)
      end

      it "redirects to the created medical_consultation" do
        post :create, params: { medical_consultation: valid_attributes }
        expect(response).to redirect_to(MedicalConsultation.last)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'new' template)" do
        post :create, params: { medical_consultation: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          reason: "Motivo de la consulta update",
          subjetive: "Que hay que hacer",
          objetive: "Que se debe hacer",
          plan: "Como se debe hacer",
          diagnosis: "Como se soluciona",
          treatment: "Con que medicamento se curará",
          observations: "Algo que decir",
          prescription: "Cloroformo por 3 días, Otra cosa",
          lab_results: "Resultados del laboratorio",
          histopathology: "No se que es",
          comments: "Algo que decir con respecto al resutaldo de laboratorio",
          doctor_id: doctor.id,
          patient_id: patient.id,
          heart_rate: 1,
          breathing_rate: 1,
          temperature: 1,
          glycaemia: 1,
          sat_02: 1,
          cost: 1
        }
      end

      it "updates the requested medical_consultation" do
        medical_consultation = MedicalConsultation.create! valid_attributes
        put :update, params: { id: medical_consultation.to_param, medical_consultation: new_attributes }
        medical_consultation.reload
        expect(medical_consultation.reason).to eq "Motivo de la consulta update"
      end

      it "redirects to the medical_consultation" do
        medical_consultation = MedicalConsultation.create! valid_attributes
        put :update, params: { id: medical_consultation.to_param, medical_consultation: valid_attributes }
        expect(response).to redirect_to(medical_consultation)
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        medical_consultation = MedicalConsultation.create! valid_attributes
        put :update, params: { id: medical_consultation.to_param, medical_consultation: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested medical_consultation" do
      medical_consultation = MedicalConsultation.create! valid_attributes
      expect {
        delete :destroy, params: { id: medical_consultation.to_param }
      }.to change(MedicalConsultation, :count).by(-1)
    end

    it "redirects to the medical_consultations list" do
      medical_consultation = MedicalConsultation.create! valid_attributes
      delete :destroy, params: { id: medical_consultation.to_param }
      expect(response).to redirect_to(medical_consultations_url)
    end
  end

end
