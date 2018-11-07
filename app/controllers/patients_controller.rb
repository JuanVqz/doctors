class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update]

  def index
    @patients = Patient.all
  end

  def show
  end

  def new
    @patient = Patient.new address: Address.new
  end

  def edit
  end

  def create
    @patient = Patient.new patient_params

    if @patient.save
      current_user.patients << @patient
      redirect_to patient_path(@patient), notice: "Paciente creado correctamente."
    else
      render :new
    end
  end

  def update
    if @patient.update(patient_params)
      redirect_to patient_path(@patient), notice: "Paciente actualizado correctamente."
    else
      render :edit
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient).permit(
      :name, :first_name, :last_name, :birthday, :height,
      :weight, :blood_group, :occupation, :referred_by,
      address_attributes: [
        :id, :street, :number, :colony, :postal_code, :municipality,
        :state, :country, :_destroy
      ]
    )
  end
end
