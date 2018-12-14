class HospitalsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hospital, only: [:edit, :update]

  def edit
    flash[:notice] = "Los datos que se requieren en esta sección seran publicos"
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
    params.require(:hospital).permit(
      :name, :schedule, :maps, :facebook, :twitter,
      :linkedin, :description, :about, :tags,
      address_attributes: [
        :id, :street, :number, :colony, :postal_code, :municipality,
        :state, :country, :_destroy
      ]
    )
  end
end
