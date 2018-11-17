class DoctorsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_doctor, only: [:show, :edit, :update]
  before_action :set_hospital, only: [:new]

  def index
    @doctores = Doctor.page(params[:page])
  end

  def show
  end

  def new
    @doctor = Doctor.new(hospital_id: @hospital.id)
  end

  def edit
  end

  def create
    @doctor = Doctor.new(doctor_params)

    if @doctor.save
      redirect_to doctor_path(@doctor), notice: "Doctor creado correctamente."
    else
      render :new
    end
  end

  def update
    if @doctor.update(doctor_params)
      redirect_to doctor_path(@doctor), notice: "Doctor actualizado correctamente."
    else
      render :edit
    end
  end

  private

  def set_hospital
    @hospital = current_hospital
  end

  def set_doctor
    @doctor = Doctor.find(params[:id])
  end

  def doctor_params
    params.require(:doctor).permit(
      :name, :first_name, :last_name, :specialty, :professional_card,
      :email, :password, :password_confirmation, :active, :hospital_id
    )
  end
end
