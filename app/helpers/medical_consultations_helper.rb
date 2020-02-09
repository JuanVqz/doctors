module MedicalConsultationsHelper
  def temperature appoiment
    if appoiment.temperature % 1 == 0
      "#{appoiment.temperature.to_i}°C"
    else
      "#{appoiment.temperature}°C"
    end
  end
end
