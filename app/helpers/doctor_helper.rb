module DoctorHelper
  def active(doctor)
    doctor.active? ? "SI" : "NO"
  end
end
