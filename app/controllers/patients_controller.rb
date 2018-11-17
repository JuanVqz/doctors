class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update]

  def index
    @patients = Patient.page(params[:page])
  end

  def show
    @medical_consultations = MedicalConsultation.by_patient(current_user.id, @patient.id).page(params[:page])
    @hospitalizations = Hospitalization.by_patient(current_user.id, @patient.id).page(params[:page])
  end

  def new
    @patient = Patient.new(address: Address.new, clinic_history: ClinicHistory.new)
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
      :place_of_birth, :sex, :cellphone,
      address_attributes: [
        :id, :street, :number, :colony, :postal_code, :municipality,
        :state, :country, :_destroy
      ],
      clinic_history_attributes: [
        :id, :description_diabetes, :description_hypertension,
        :description_allergic, :description_traumatic,
        :description_transfusion, :description_surgical,
        :description_drug_addiction, :description_cancer,
        :description_other, :patien_id, :_destroy
      ]
    )
  end
end
