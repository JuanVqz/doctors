class ReferredDoctorsController < ApplicationController
  before_action :set_referred_doctor, only: %i[ show edit update destroy ]

  # GET /referred_doctors
  # GET /referred_doctors.json
  def index
    @referred_doctors = current_user.referred_doctors.page(params[:page])
  end

  # GET /referred_doctors/1
  # GET /referred_doctors/1.json
  def show
  end

  # GET /referred_doctors/new
  def new
    @referred_doctor = ReferredDoctor.new
  end

  # GET /referred_doctors/1/edit
  def edit
  end

  # POST /referred_doctors
  # POST /referred_doctors.json
  def create
    @referred_doctor = ReferredDoctor.new(referred_doctor_params)

    respond_to do |format|
      if @referred_doctor.save
        format.html { redirect_to @referred_doctor, notice: "Doctor fue creado correctamente." }
        format.json { render :show, status: :created, location: @referred_doctor }
      else
        format.html { render :new }
        format.json { render json: @referred_doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referred_doctors/1
  # PATCH/PUT /referred_doctors/1.json
  def update
    respond_to do |format|
      if @referred_doctor.update(referred_doctor_params)
        format.html { redirect_to @referred_doctor, notice: "Doctor actualizado correctamente." }
        format.json { render :show, status: :ok, location: @referred_doctor }
      else
        format.html { render :edit }
        format.json { render json: @referred_doctor.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referred_doctors/1 or /referred_doctors/1.json
  def destroy
    @referred_doctor.destroy
    respond_to do |format|
      format.html { redirect_to referred_doctors_url, notice: "Doctor eliminado correctamente." }
      format.json { head :no_content }
    end
  end

  private

  def set_referred_doctor
    @referred_doctor = ReferredDoctor.find(params[:id])
  end

  def referred_doctor_params
    params.require(:referred_doctor)
      .permit(:full_name, :specialty)
      .with_defaults(doctor: current_user)
  end
end
