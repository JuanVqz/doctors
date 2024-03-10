module AppointmentsHelper
  def temperature appointment
    if appointment.temperature % 1 == 0
      "#{appointment.temperature.to_i}°C"
    else
      "#{appointment.temperature}°C"
    end
  end
end
