class PatientReferralsController < ApplicationController
  before_action :set_patient_referral, only: %i[show edit update destroy]

  # GET /patient_referrals
  def index
    @patient_referrals =
      current_hospital
        .patient_referrals
        .order(created_at: :desc)
  end

  # GET /patient_referrals/1
  def show
    respond_to do |format|
      format.html
      format.pdf {
        render pdf: patient_referral_name,
          template: "pdfs/patient_referral",
          layout: "pdfs/hospital"
      }
    end
  end

  # GET /patient_referrals/new
  def new
    @patient_referral = PatientReferral.new
  end

  # GET /patient_referrals/1/edit
  def edit
  end

  # POST /patient_referrals
  def create
    @patient_referral = PatientReferral.new(patient_referral_params)

    respond_to do |format|
      if @patient_referral.save
        format.html { redirect_to @patient_referral, notice: "Referencia del paciente creada correctamente." }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /patient_referrals/1
  def update
    respond_to do |format|
      if @patient_referral.update(patient_referral_params)
        format.html { redirect_to @patient_referral, notice: "Referenca del paciente actualizada correctamente." }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /patient_referrals/1
  def destroy
    @patient_referral.destroy
    respond_to do |format|
      format.html { redirect_to patient_referrals_url, notice: "Referenca del paciente eliminado correctamente." }
    end
  end

  private

  def set_patient_referral
    @patient_referral = PatientReferral.find(params[:id])
  end

  def patient_referral_params
    params.require(:patient_referral)
      .permit(:subject, :content, :importance, :patient_id, :referred_doctor_id)
      .with_defaults(hospital_id: current_user.hospital_id, doctor_id: current_user.id)
  end

  def patient_referral_name
    "#{@patient_referral.id}_#{@patient_referral.created_at.to_fs(:number)}".upcase
  end
end
