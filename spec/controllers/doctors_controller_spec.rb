require 'rails_helper'

RSpec.describe DoctorsController, type: :controller do

  let(:hospital) { create :hospital, subdomain: "ursula" }
  let(:doctor) { create :doctor, hospital_id: hospital.id }

  let(:valid_attributes) do
    {
      name: "Jonh",
      first_name: "Doe",
      last_name: "Foo",
      specialty: "Medico General",
      professional_card: "123123123",
      email: "jonh@gmail.com",
      password: "123456",
      hospital_id: hospital.id
    }
  end

  let(:invalid_attributes) do
    {
      name: nil,
      first_name: "Pérez",
      last_name: "Ramos",
      specialty: "Medico General",
      professional_card: "123123123",
      email: "jonh@gmail.com",
      password: "123456",
      hospital_id: hospital.id
    }
  end

  before(:each) do
    @request.host = "#{hospital.subdomain}.lvh.me"
    sign_in doctor
  end

  describe "GET #index" do
    it "returns a success response" do
      Doctor.create! valid_attributes
      get :index, params: {}
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      doctor = Doctor.create! valid_attributes
      get :show, params: { id: doctor.to_param }
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
      doctor = Doctor.create! valid_attributes
      get :edit, params: { id: doctor.to_param }
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Doctor" do
        expect {
          post :create, params: { doctor: valid_attributes }
        }.to change(Doctor, :count).by(2)
      end

      it "redirects to the created doctor" do
        post :create, params: { doctor: valid_attributes }
        expect(response).to redirect_to(doctor_path(Doctor.last))
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) do
        {
          name: "Jonh Update",
          first_name: "Doe",
          last_name: "Foo",
          specialty: "Medico General",
          professional_card: "123123123",
          email: "jonh@gmail.com",
          hospital_id: hospital.id
        }
      end

      it "updates the requested doctor" do
        doctor = Doctor.create! valid_attributes
        put :update, params: { id: doctor.to_param, doctor: new_attributes }
        doctor.reload
        expect(doctor.name).to eq "Jonh Update"
      end
    end

    context "with invalid params" do
      it "returns a success response (i.e. to display the 'edit' template)" do
        doctor = Doctor.create! valid_attributes
        put :update, params: { id: doctor.to_param, doctor: invalid_attributes }
        expect(response).to be_successful
      end
    end
  end
end
