class AppointmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appoinment, only: [:show, :edit, :update, :destroy]

  def index
    @pagy, @appointments = pagy(Appointment.includes(:patient).per_doctor(current_user.id).search(params[:query]).recent)
  end

  def show
    respond_to do |format|
      format.html
      format.pdf {
        render pdf: prescription_name,
          template: "pdfs/prescription_#{current_hospital.subdomain}",
          layout: "pdfs/prescription"
      }
    end
  end

  def new
    patient_from_params
    @appointments = @patient.appointments.where.not(id: nil).take(3)
    @appointment = @patient.appointments.build(height: @patient.height, weight: @patient.weight)
  end

  def edit
  end

  def create
    @appointment = current_user.appointments.build(appoinment_params)

    respond_to do |format|
      if @appointment.save
        format.html { redirect_to @appointment, notice: "Consulta creada correctamente." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @appointment.update(appoinment_params)
        format.html { redirect_to @appointment, notice: "Consulta actualizada correctamente." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appointment.destroy
    respond_to do |format|
      format.html { redirect_to appointments_url, notice: "Consulta eliminada correctamente." }
    end
  end

  private

  def prescription_name
    "#{@appointment.patient.name}_#{@appointment.id}_#{@appointment.created_at.to_fs(:number)}".upcase
  end

  def set_appoinment
    @appointment = Appointment.includes(:patient).find(params[:id])
  end

  def patient_from_params
    @patient =
      current_hospital.patients.find_by(id: params[:patient_id]) ||
      current_hospital.patients.new(height: 0.0, weight: 0.0)
  end

  def appoinment_params
    params.require(:appointment)
      .permit(
        :reason, :note, :prescription,
        :recommendations, :patient_id, :imc, :weight, :height, :blood_pressure,
        :heart_rate, :breathing_rate, :temperature, :glycaemia, :sat_02, :cost,
        :cabinet_results, :histopathology, files: []
      ).with_defaults(hospital_id: current_hospital.id)
  end
end
