class PatientReferralsController < ApplicationController
  before_action :set_patient_referral, only: %i[ show edit update destroy ]

  # GET /patient_referrals
  # GET /patient_referrals.json
  def index
    @patient_referrals =
      PatientReferral
      .by_hospital(current_user.hospital_id)
      .order(created_at: :desc)
      .page(params[:page])
  end

  # GET /patient_referrals/1
  # GET /patient_referrals/1.json
  def show
    respond_to do |format|
      format.html
      format.pdf { render pdf: patient_referral_name,
                    template: "pdfs/patient_referral",
                    layout: "pdfs/hospital" }
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
  # POST /patient_referrals.json
  def create
    @patient_referral = PatientReferral.new(patient_referral_params)

    respond_to do |format|
      if @patient_referral.save
        format.html { redirect_to @patient_referral, notice: "Referencia del paciente creada correctamente." }
        format.json { render :show, status: :created, location: @patient_referral }
      else
        format.html { render :new }
        format.json { render json: @patient_referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /patient_referrals/1
  # PATCH/PUT /patient_referrals/1.json
  def update
    respond_to do |format|
      if @patient_referral.update(patient_referral_params)
        format.html { redirect_to @patient_referral, notice: "Referenca del paciente actualizada correctamente." }
        format.json { render :show, status: :ok, location: @patient_referral }
      else
        format.html { render :edit }
        format.json { render json: @patient_referral.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /patient_referrals/1
  # DELETE /patient_referrals/1.json
  def destroy
    @patient_referral.destroy
    respond_to do |format|
      format.html { redirect_to patient_referrals_url, notice: "Referenca del paciente eliminado correctamente." }
      format.json { head :no_content }
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
    "#{@patient_referral.id}_#{@patient_referral.created_at.to_s(:number)}".upcase
  end
end
