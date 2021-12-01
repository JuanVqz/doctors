module ApplicationHelper
  def is_admin?
    current_user.admin?
  end

  def active_for current
    return "is-active" if request.path.include? current
  end

  def sexos_for_select
    ["Masculino", "Femenino"]
  end

  def patients_for_select
    Patient.all.map { |p| [p, p.id] }
  end

  def referred_doctor_for_select
    return [] unless current_user.present?

    ReferredDoctor.by_doctor(current_user.id).map { |p| [p, p.id] }
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
