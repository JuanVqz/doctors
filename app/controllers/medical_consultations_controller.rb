class MedicalConsultationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_medical_consultation, only: [:show, :edit, :update, :destroy]

  def index
    @medical_consultations = MedicalConsultation.includes(:patient)
      .per_doctor(current_user.id)
      .recent
      .page(params[:page])
  end

  def show
  end

  def new
    @medical_consultation = MedicalConsultation.new
  end

  def edit
  end

  def create
    @medical_consultation = current_user.medical_consultations.build(medical_consultation_params)

    if @medical_consultation.save
      redirect_to @medical_consultation, notice: 'Consulta creada correctamente.'
    else
      render :new
    end
  end

  def update
    if @medical_consultation.update(medical_consultation_params)
      redirect_to @medical_consultation, notice: 'Consulta actualizada correctamente.'
    else
      render :edit
    end
  end

  def destroy
    @medical_consultation.destroy
    redirect_to medical_consultations_url, notice: 'Medical consultation was successfully destroyed.'
  end

  private

    def set_medical_consultation
      @medical_consultation = MedicalConsultation.find(params[:id])
    end

    def medical_consultation_params
      params.require(:medical_consultation).permit(
        :reason, :subjetive, :objetive, :plan, :diagnosis, :treatment, :observations, :prescription,
        :lab_results, :histopathology, :comments, :patient_id
      )
    end
end
