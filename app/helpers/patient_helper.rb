module PatientHelper
  def age patient
    now = Date.current
    age = now.year - patient.birthday.year
    age -= 1 if now.yday < patient.birthday.yday
    "#{age} Años"
  end
end
