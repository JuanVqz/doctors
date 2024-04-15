# frozen_string_literal: true

module PatientHelper
  def age(patient)
    return if patient.birthday.nil?

    now = Date.current
    age = now.year - patient.birthday.year
    age -= 1 if now.yday < patient.birthday.yday
    "#{age} Años"
  end

  def age_months(patient)
    return if patient.birthday.nil?

    now = Date.current
    year = now.year - patient.birthday.year
    year -= 1 if now.yday < patient.birthday.yday

    months = now.month - patient.birthday.month
    months %= 12

    "#{year} años #{months} meses"
  end
end
