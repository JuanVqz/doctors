class HospitalizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hospitalization, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @hospitalizations = pagy(current_hospital.hospitalizations.includes(:patient).search(params[:query]).recent)
  end

  def show
    respond_to do |format|
      format.html
      format.pdf {
        render pdf: pdf_name,
          template: "pdfs/hospitalization",
          layout: "pdfs/hospital"
      }
    end
  end

  def new
    @hospitalization = Hospitalization.new(patient_id: patient_id_param)
  end

  def edit
  end

  def create
    @hospitalization = current_user.hospitalizations.new(hospitalization_params)

    if @hospitalization.save
      redirect_to @hospitalization, notice: "Hospitalización creada correctamente."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def update
    if @hospitalization.update(hospitalization_params)
      redirect_to @hospitalization, notice: "Hospitalización actualizado correctamente."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @hospitalization.destroy
    redirect_to hospitalizations_url, notice: "Hospitalizacion eliminada correctamente."
  end

  private

  def set_hospitalization
    @hospitalization = Hospitalization.find(params[:id])
  end

  def pdf_name
    "#{@hospitalization.patient.name}_#{@hospitalization.id}_#{@hospitalization.created_at.to_fs(:number)}".upcase
  end

  def patient_id_param
    current_hospital.patients.find_by(id: params[:patient_id])&.to_param
  end

  def hospitalization_params
    params.require(:hospitalization).permit(
      :starting, :ending, :days_of_stay, :reason_for_hospitalization,
      :treatment, :patient_id, :input_diagnosis, :output_diagnosis,
      :recommendations, :referred_doctor_id, :status
    ).with_defaults(hospital_id: current_hospital.id)
  end
end
