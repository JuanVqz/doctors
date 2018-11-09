class MedicalConsultationsController < ApplicationController
  before_action :set_medical_consultation, only: [:show, :edit, :update, :destroy]
  before_action :set_hospital, only: [:new]

  # GET /medical_consultations
  # GET /medical_consultations.json
  def index
    @medical_consultations = MedicalConsultation.all
  end

  # GET /medical_consultations/1
  # GET /medical_consultations/1.json
  def show
  end

  # GET /medical_consultations/new
  def new
    @medical_consultation = MedicalConsultation.new(hospital_id: @hospital.id)
  end

  # GET /medical_consultations/1/edit
  def edit
  end

  # POST /medical_consultations
  # POST /medical_consultations.json
  def create
    @medical_consultation = current_user.medical_consultations.build(medical_consultation_params)

    respond_to do |format|
      if @medical_consultation.save
        format.html { redirect_to @medical_consultation, notice: 'Medical consultation was successfully created.' }
        format.json { render :show, status: :created, location: @medical_consultation }
      else
        format.html { render :new }
        format.json { render json: @medical_consultation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /medical_consultations/1
  # PATCH/PUT /medical_consultations/1.json
  def update
    respond_to do |format|
      if @medical_consultation.update(medical_consultation_params)
        format.html { redirect_to @medical_consultation, notice: 'Medical consultation was successfully updated.' }
        format.json { render :show, status: :ok, location: @medical_consultation }
      else
        format.html { render :edit }
        format.json { render json: @medical_consultation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /medical_consultations/1
  # DELETE /medical_consultations/1.json
  def destroy
    @medical_consultation.destroy
    respond_to do |format|
      format.html { redirect_to medical_consultations_url, notice: 'Medical consultation was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    def set_hospital
      @hospital = current_hospital
    end

    def set_medical_consultation
      @medical_consultation = MedicalConsultation.find(params[:id])
    end

    def medical_consultation_params
      params.require(:medical_consultation).permit(
        :reason, :subjetive, :objetive, :plan, :diagnosis, :treatment, :observations, :prescription,
        :lab_results, :histopathology, :comments, :patient_id, :hospital_id
      )
    end
end
