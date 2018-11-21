class HospitalizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hospitalization, only: [:show, :edit, :update, :destroy]

  def index
    @hospitalizations = Hospitalization.includes(:patient)
      .per_doctor(current_user.id)
      .recent
      .page(params[:page])
  end

  def show
  end

  def new
    @hospitalization = Hospitalization.new(patient_id: params[:patient])
  end

  def edit
  end

  def create
    @hospitalization = current_user.hospitalizations.new(hospitalization_params)

    if @hospitalization.save
      redirect_to @hospitalization, notice: 'Hospitalización creada correctamente.'
    else
      render :new
    end
  end

  def update
    if @hospitalization.update(hospitalization_params)
      redirect_to @hospitalization, notice: 'Hospitalización actualizado correctamente.'
    else
      render :edit
    end
  end

  def destroy
    @hospitalization.destroy
    redirect_to hospitalizations_url, notice: 'Hospitalizacion eliminada correctamente.'
  end

  private

    def set_hospitalization
      @hospitalization = Hospitalization.find(params[:id])
    end

    def hospitalization_params
      params.require(:hospitalization).permit(
        :starting, :ending, :days_of_stay, :reason_for_hospitalization,
        :treatment, :doctor_id, :patient_id
      )
    end
end
