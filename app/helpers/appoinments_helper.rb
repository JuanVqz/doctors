module AppoinmentsHelper
  def temperature appoinment
    if appoinment.temperature % 1 == 0
      "#{appoinment.temperature.to_i}°C"
    else
      "#{appoinment.temperature}°C"
    end
  end
end
