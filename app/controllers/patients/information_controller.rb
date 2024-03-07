class Patients::InformationController < ApplicationController
  def index
    @patient = current_hospital.patients.includes(:appoinments).find(params[:patient_id])
    @appoinments = @patient.appoinments.take(3)

    respond_to(&:turbo_stream)
  end
end
