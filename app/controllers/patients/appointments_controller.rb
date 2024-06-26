# frozen_string_literal: true

module Patients
  class AppointmentsController < ApplicationController
    def index
      @patient = current_hospital.patients.includes(:appointments).find(params[:patient_id])
      @pagy, @appointments = pagy(@patient.appointments)
    end
  end
end
