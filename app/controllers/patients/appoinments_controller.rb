class Patients::AppoinmentsController < ApplicationController
  def index
    @patient = current_hospital.patients.includes(:appoinments).find(params[:patient_id])
    @appoinments = @patient.appoinments
  end
end
