require "rails_helper"

RSpec.describe PatientsController, type: :controller do
  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:address) { attributes_for :address }

  let(:valid_attributes) do
    {
      name: "Marco",
      first_name: "Chavez",
      last_name: "Castro",
      birthday: "1989-09-19",
      height: 180,
      weight: 100,
      blood_group: "ARH+",
      occupation: "Herrero",
      referred_by: "Pedro Ramos",
      place_of_birth: "Oaxaca de Juárez",
      cellphone: "951 123 45 67",
      sex: "Masculino",
      hospital_id: hospital.id,
      address_attributes: address,
      marital_status: "Casado",
      comments: "Algo que decir"
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      first_name: "Chavez",
      last_name: "Castro",
      birthday: "1989-09-19",
      height: 180,
      weight: 100,
      blood_group: "ARH+",
      occupation: "Herrero",
      referred_by: "Pedro Ramos",
      place_of_birth: "Oaxaca de Juárez",
      cellphone: "951 123 45 67",
      sex: "Masculino",
      hospital_id: hospital.id,
      address_attributes: address
    }
  end

  before(:each) do
    allow(Hospital).to receive(:current_id).and_return hospital.id
    @request.host = "#{hospital.subdomain}.lvh.me"
    sign_in doctor
  end

  describe "GET #index" do
    it "returns a success response" do
      doctor.patients.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      patient = Patient.create! valid_attributes
      get :show, params: { id: patient.to_param }
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
      patient = Patient.create! valid_attributes
      get :edit, params: { id: patient.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Patient" do
        expect {
          post :create, params: { patient: valid_attributes }
        }.to change(Patient, :count).by(1)
      end

      it "creates a new Address" do
        expect {
          post :create, params: { patient: valid_attributes }
        }.to change(Address, :count).by(1)
      end

      it "redirects to the created doctor" do
        post :create, params: { patient: valid_attributes }
        expect(response).to redirect_to(patient_path(Patient.last))
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          name: "Marco Update",
          first_name: "Chavez",
          last_name: "Castro",
          birthday: "1989-09-19",
          height: 180,
          weight: 100,
          blood_group: "ARH+",
          occupation: "Herrero",
          referred_by: "Pedro Ramos",
          place_of_birth: "Oaxaca de Juárez",
          cellphone: "951 123 45 67",
          sex: "Masculino",
          hospital_id: hospital.id,
          address_attributes: address
        }
      end

      it "updates the requested patient" do
        patient = Patient.create! valid_attributes
        put :update, params: { id: patient.to_param, patient: new_attributes }
        patient.reload
        expect(patient.name).to eq "Marco Update"
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        patient = Patient.create! valid_attributes
        put :update, params: { id: patient.to_param, patient: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
