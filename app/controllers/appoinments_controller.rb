class AppoinmentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_appoinment, only: [:show, :edit, :update, :destroy]

  def index
    @appoinments = Appoinment.includes(:patient)
      .per_doctor(current_user.id)
      .search(params[:query])
      .recent
      .page(params[:page])
  end

  def show
    respond_to do |format|
      format.html
      format.pdf { render pdf: prescription_name,
                    template: "pdfs/prescription_#{current_hospital.subdomain}",
                    layout: "pdfs/prescription" }
    end
  end

  def new
    @appoinment = Appoinment.new
  end

  def edit
  end

  def create
    @appoinment = current_user.appoinments.build(appoinment_params)

    respond_to do |format|
      if @appoinment.save
        format.html { redirect_to @appoinment, notice: "Consulta creada correctamente." }
        format.json { render :show, status: :created, location: @appoinment }
      else
        format.html { render :new }
        format.json { render json: @appoinment.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @appoinment.update(appoinment_params)
        format.html { redirect_to @appoinment, notice: "Consulta actualizada correctamente." }
        format.json { render :show, status: :ok, location: @appoinment }
      else
        format.html { render :edit }
        format.json { render json: @appoinment.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @appoinment.destroy
    respond_to do |format|
      format.html { redirect_to appoinments_url, notice: "Consulta eliminada correctamente." }
      format.json { head :no_content }
    end
  end

  private

  def prescription_name
    "#{@appoinment.patient.name}_#{@appoinment.id}_#{@appoinment.created_at.to_s(:number)}".upcase
  end

  def set_appoinment
    @appoinment = Appoinment.includes(:patient).find(params[:id])
  end

  def appoinment_params
    params.require(:appoinment).permit(:reason, :note, :prescription,
      :recommendations, :patient_id, :imc, :weight, :height, :blood_pressure,
      :heart_rate, :breathing_rate, :temperature, :glycaemia, :sat_02, :cost,
      :cabinet_results, :histopathology)
  end
end