module ApplicationHelper
  include Pagy::Frontend

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

  def primary_button
    "text-white text-center bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-none dark:focus:ring-blue-800"
  end

  def sidebar_classes action
    classes = "flex p-2 rounded-lg hover:bg-gray-200 dark:hover:bg-gray-700"
    classes += " bg-gray-200 dark:bg-gray-700" if controller_name == action

    classes
  end
end
