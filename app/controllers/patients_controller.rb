class PatientsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_patient, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @patients = pagy(current_hospital.patients.recent.search(params[:query]))
  end

  def show
  end

  def new
    @patient = Patient.new(address: Address.new)
  end

  def edit
  end

  def create
    @patient = Patient.new patient_params

    if @patient.save
      current_user.patients << @patient
      redirect_to patient_path(@patient), notice: "Paciente creado correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @patient.update(patient_params)
      redirect_to @patient, notice: "Paciente actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @patient.destroy

    respond_to do |format|
      format.html { redirect_to patients_url, notice: "Paciente eliminado correctamente." }
    end
  end

  private

  def set_patient
    @patient = Patient.find(params[:id])
  end

  def patient_params
    params.require(:patient)
      .permit(
        :name, :first_name, :last_name, :birthday, :height,
        :weight, :blood_group, :occupation, :referred_by,
        :place_of_birth, :sex, :cellphone, :marital_status,
        :comments, :avatar, :allergies, :pathological_background,
        :non_pathological_background, :gyneco_obstetric_background,
        :system_background, :family_inheritance_background,
        :physic_exploration, :other_background,
        address_attributes: [
          :id, :street, :number, :colony, :postal_code, :municipality,
          :state, :country, :_destroy
        ]
      ).with_defaults(hospital: current_user.hospital)
  end

  def pdf_name
    "#{@patient.name}_#{@patient.id}_#{@patient.created_at.to_fs(:number)}".upcase
  end
end
