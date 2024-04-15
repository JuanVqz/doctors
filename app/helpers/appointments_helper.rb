# frozen_string_literal: true

module AppointmentsHelper
  def temperature(appointment)
    if (appointment.temperature % 1).zero?
      "#{appointment.temperature.to_i}°C"
    else
      "#{appointment.temperature}°C"
    end
  end
end
