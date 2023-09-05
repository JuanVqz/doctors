module ApplicationHelper
  def sexos_for_select
    ["Femenino", "Masculino"]
  end

  def patients_for_select
    @patients_for_select ||=
      current_hospital
        .patients
        .order(name: :asc, first_name: :asc, last_name: :asc)
        .map { |p| [p, p.id] }
  end

  def referred_doctor_for_select
    @referred_doctor_for_select ||=
      ReferredDoctor
        .by_doctor(current_user.id)
        .order(full_name: :asc)
        .map { |p| [p, p.id] }
  end

  def states_for_select
    [
      "Aguascalientes", "Baja California", "Baja California Sur",
      "Campeche", "Chiapas", "Chihuahua", "Ciudad de México", "Coahuila",
      "Colima", "Durango", "Guanajuato", "Guerrero", "Hidalgo", "Jalisco",
      "Estado de México", "Michoacán", "Morelos", "Nayarit", "Nuevo León",
      "Oaxaca", "Puebla", "Querétaro", "Quintana Roo", "San Luis Potosí",
      "Sinaloa", "Sonora", "Tabasco", "Tamaulipas", "Tlaxcala", "Veracruz",
      "Yucatán", "Zacatecas"
    ]
  end

  def blood_groups_for_select
    ["ARH+", "ORH+", "BRH+", "ABRH+", "ARH-", "ORH-", "BRH-", "ABRH-"]
  end
end
