# frozen_string_literal: true

module ApplicationHelper
  include Pagy::Frontend

  def sexos_for_select
    %w[Femenino Masculino]
  end

  def patients_for_select
    @patients_for_select ||=
      current_hospital
      .patients
      .order(name: :asc, first_name: :asc, last_name: :asc)
      .map { |u| [u.to_s, u.id] }
  end

  def combobox_error(object, field, type = :blank)
    return unless object.errors.added?(field, type)

    content_tag(:p, object.errors.full_messages_for(field).first, class: 'mt-2 text-sm text-red-600 dark:text-red-600')
  end

  def referred_doctors_for_select
    @referred_doctors_for_select ||=
      current_hospital
      .referred_doctors
      .order(full_name: :asc)
      .map { |u| [u.to_s, u.id] }
  end

  def states_for_select
    [
      'Aguascalientes', 'Baja California', 'Baja California Sur',
      'Campeche', 'Chiapas', 'Chihuahua', 'Ciudad de México', 'Coahuila',
      'Colima', 'Durango', 'Guanajuato', 'Guerrero', 'Hidalgo', 'Jalisco',
      'Estado de México', 'Michoacán', 'Morelos', 'Nayarit', 'Nuevo León',
      'Oaxaca', 'Puebla', 'Querétaro', 'Quintana Roo', 'San Luis Potosí',
      'Sinaloa', 'Sonora', 'Tabasco', 'Tamaulipas', 'Tlaxcala', 'Veracruz',
      'Yucatán', 'Zacatecas'
    ]
  end

  def blood_groups_for_select
    ['ARH+', 'ORH+', 'BRH+', 'ABRH+', 'ARH-', 'ORH-', 'BRH-', 'ABRH-']
  end

  def primary_button
    'text-white text-center bg-blue-700 hover:bg-blue-800 focus:ring-4 focus:ring-blue-300 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-blue-600 dark:hover:bg-blue-700 focus:outline-hidden dark:focus:ring-blue-800'
  end

  def secondary_button
    'text-gray-900 bg-white border border-gray-300 focus:outline-hidden hover:bg-gray-100 focus:ring-4 focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-gray-800 dark:text-white dark:border-gray-600 dark:hover:bg-gray-700 dark:hover:border-gray-600 dark:focus:ring-gray-700' # rubocop:disable Layout/LineLength
  end

  def delete_button
    'text-white bg-red-600 border border-gray-300 focus:outline-hidden hover:bg-red-800 focus:ring-4 focus:ring-gray-100 font-medium rounded-lg text-sm px-5 py-2.5 dark:bg-red-600 dark:text-white dark:border-red-800 dark:hover:bg-red-700 dark:hover:border-red-600 dark:focus:ring-gray-700'
  end

  def link_button
    'text-blue-600 dark:text-blue-500 hover:underline'
  end

  def label_classes
    'block mb-2 text-sm font-medium text-gray-900 dark:text-white string required'
  end

  def sidebar_classes(action)
    classes = 'flex p-2 rounded-lg hover:bg-gray-200 dark:hover:bg-gray-700'
    classes += ' bg-gray-200 dark:bg-gray-700' if controller_name.to_sym.eql?(action)

    classes
  end

  def height_for_human(object)
    "#{object.height} cm"
  end

  def weight_for_human(object)
    "#{object.weight} kg"
  end

  def imc_for_human(object)
    return if object.height.to_f.zero? || object.weight.to_f.zero?

    "#{(object.weight / ((object.height / 100.0)**2)).round(2)} IMC"
  end
end
