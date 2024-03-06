class Patients::InformationController < ApplicationController
  def index
    @patient = current_hospital.patients.includes(:appoinments).find(params[:patient_id])

    respond_to(&:turbo_stream)
  end
end
