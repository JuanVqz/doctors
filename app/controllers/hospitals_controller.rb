class HospitalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hospital, only: [:edit, :update]

  def edit
  end

  def update
    if @hospital.update(hospital_params)
      redirect_to [:edit, @hospital], notice: 'Datos actualizados correctamente.'
    else
      render :edit
    end
  end

  private

  def set_hospital
    @hospital = Hospital.find(params[:id])
  end

  def hospital_params
    params.require(:hospital).permit(:name, :description)
  end
end
