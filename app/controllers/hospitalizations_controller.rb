class HospitalizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hospitalization, only: [:show, :edit, :update, :destroy]

  def index
    @hospitalizations = Hospitalization.includes(:patient)
      .per_doctor(current_user.id)
      .search(params[:query])
      .recent
      .page(params[:page])
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
    @hospitalization = Hospitalization.new(patient_id: params[:patient])
  end

  def edit
  end

  def create
    @hospitalization = current_user.hospitalizations.new(hospitalization_params)

    if @hospitalization.save
      redirect_to @hospitalization, notice: "Hospitalización creada correctamente."
    else
      render :new
    end
  end

  def update
    if @hospitalization.update(hospitalization_params)
      redirect_to @hospitalization, notice: "Hospitalización actualizado correctamente."
    else
      render :edit
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

  def hospitalization_params
    params.require(:hospitalization).permit(
      :starting, :ending, :days_of_stay, :reason_for_hospitalization,
      :treatment, :doctor_id, :patient_id, :input_diagnosis, :output_diagnosis,
      :recommendations, :referred_doctor_id, :status
    )
  end
end
