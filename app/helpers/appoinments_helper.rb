module AppoinmentsHelper
  def temperature appoinment
    if appoinment.temperature % 1 == 0
      "#{appoinment.temperature.to_i}°C"
    else
      "#{appoinment.temperature}°C"
    end
  end

  def selected_appoinnment_patient(appoinment)
    appoinment.patient_id.presence || params[:patient_id]
  end
end
