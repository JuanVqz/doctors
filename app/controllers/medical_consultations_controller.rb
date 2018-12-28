class MedicalConsultationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_medical_consultation, only: [:show, :edit, :update, :destroy]

  def index
    @medical_consultations = MedicalConsultation.includes(:patient)
      .per_doctor(current_user.id)
      .search(params[:query])
      .recent
      .page(params[:page])
  end

  def show
    respond_to do |format|
      format.html
      format.pdf { render pdf: prescription_name,
                    template: "pdfs/prescription",
                    layout: "pdfs/prescription" }
    end
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
      @medical_consultation = MedicalConsultation.includes(:patient).find(params[:id])
    end

    def prescription_name
      "#{@medical_consultation.patient.name}_#{@medical_consultation.id}_#{@medical_consultation.created_at.to_s(:number)}".upcase
    end

    def medical_consultation_params
      params.require(:medical_consultation).permit(
        :reason, :subjetive, :objetive, :plan, :diagnosis, :treatment,
        :observations, :prescription, :lab_results, :histopathology, :comments,
        :height, :weight, :imc, :patient_id
      )
    end
end
