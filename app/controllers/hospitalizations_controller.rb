class HospitalizationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_hospitalization, only: [:show, :edit, :update, :destroy]
  before_action :set_hospital, only: [:new]

  # GET /hospitalizations
  # GET /hospitalizations.json
  def index
    @hospitalizations = current_user.hospitalizations
  end

  # GET /hospitalizations/1
  # GET /hospitalizations/1.json
  def show
  end

  # GET /hospitalizations/new
  def new
    @hospitalization = Hospitalization.new(hospital_id: @hospital.id, patient_id: params[:patient])
  end

  # GET /hospitalizations/1/edit
  def edit
  end

  # POST /hospitalizations
  # POST /hospitalizations.json
  def create
    @hospitalization = current_user.hospitalizations.new(hospitalization_params)

    respond_to do |format|
      if @hospitalization.save
        format.html { redirect_to @hospitalization, notice: 'Hospitalización creada correctamente.' }
        format.json { render :show, status: :created, location: @hospitalization }
      else
        format.html { render :new }
        format.json { render json: @hospitalization.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hospitalizations/1
  # PATCH/PUT /hospitalizations/1.json
  def update
    respond_to do |format|
      if @hospitalization.update(hospitalization_params)
        format.html { redirect_to @hospitalization, notice: 'Hospitalización actualizado correctamente.' }
        format.json { render :show, status: :ok, location: @hospitalization }
      else
        format.html { render :edit }
        format.json { render json: @hospitalization.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hospitalizations/1
  # DELETE /hospitalizations/1.json
  def destroy
    @hospitalization.destroy
    respond_to do |format|
      format.html { redirect_to hospitalizations_url, notice: 'Hospitalizacion eliminada correctamente.' }
      format.json { head :no_content }
    end
  end

  private
    def set_hospital
      @hospital = current_hospital
    end

    def set_hospitalization
      @hospitalization = Hospitalization.find(params[:id])
    end

    def hospitalization_params
      params.require(:hospitalization).permit(
        :starting, :ending, :days_of_stay, :reason_for_hospitalization,
        :treatment, :doctor_id, :patient_id, :hospital_id
      )
    end
end
