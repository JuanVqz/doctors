# frozen_string_literal: true

module Patients
  class InformationController < ApplicationController
    def index
      @patient = current_hospital.patients.includes(:appointments).find(params[:patient_id])
      @appointments = @patient.appointments.take(3)

      respond_to(&:turbo_stream)
    end
  end
end
