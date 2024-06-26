# frozen_string_literal: true

class ReferredDoctorsController < ApplicationController
  before_action :set_referred_doctor, only: %i[show edit update destroy]

  # GET /referred_doctors
  def index
    @pagy, @referred_doctors = pagy(current_hospital.referred_doctors.search(params[:query]).order(:full_name))
  end

  # GET /referred_doctors/1
  def show; end

  # GET /referred_doctors/new
  def new
    @referred_doctor = ReferredDoctor.new(address: Address.new)
  end

  # GET /referred_doctors/1/edit
  def edit; end

  # POST /referred_doctors
  def create
    @referred_doctor = ReferredDoctor.new(referred_doctor_params)

    respond_to do |format|
      if @referred_doctor.save
        format.html { redirect_to @referred_doctor, notice: 'Doctor fue creado correctamente.' }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /referred_doctors/1
  def update
    respond_to do |format|
      if @referred_doctor.update(referred_doctor_params)
        format.html { redirect_to @referred_doctor, notice: 'Doctor actualizado correctamente.' }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /referred_doctors/1
  def destroy
    @referred_doctor.destroy
    respond_to do |format|
      format.html { redirect_to referred_doctors_url, notice: 'Doctor eliminado correctamente.' }
    end
  end

  private

  def set_referred_doctor
    @referred_doctor = ReferredDoctor.find(params[:id])
  end

  def referred_doctor_params
    params.require(:referred_doctor)
          .permit(:full_name, :specialty, :phone_number, address_attributes: %i[
                    id street number colony postal_code municipality
                    state country _destroy
                  ])
          .with_defaults(doctor_id: current_user.to_param, hospital_id: current_user.hospital_id)
  end
end
