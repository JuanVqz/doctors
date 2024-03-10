class Patients::AppointmentsController < ApplicationController
  def index
    @patient = current_hospital.patients.includes(:appointments).find(params[:patient_id])
    @appointments = @patient.appointments
  end
end
