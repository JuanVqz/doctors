# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Hospitalization's flow", type: :system do
  before do
    driven_by(:headless_firefox)
  end

  feature 'Doctor' do
    scenario 'can create an hospitalization from patient list' do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      patient = create(:patient, hospital: @hospital)
      referred_doctor = create(:referred_doctor, doctor: @admin, hospital: @hospital)

      visit patients_path
      expect(page).to have_content 'Buscar'
      expect(page).to have_current_path(patients_path)

      within "tr[data-patient-id='#{patient.id}']" do
        find('a[data-tooltip="Detalles"]').click
      end

      find('a[data-tooltip="Nueva Hospitalización"]').click
      expect(page).to have_current_path(new_hospitalization_path(patient_id: patient.id))

      expect_combobox('input[name="hospitalization[patient_id]"]', value: patient.to_param)

      delete_from_combobox('#hospitalization_referred_doctor_id', referred_doctor.to_s, original: '')
      click_on_option(referred_doctor.to_s)
      expect_combobox('input[name="hospitalization[referred_doctor_id]"]', value: referred_doctor.to_param)

      fill_up_hospitalization_form
      click_button 'Registrar Hospitalización'

      expect(page).to have_current_path hospitalization_path Hospitalization.last
      expect(page).to have_content 'INFORMACIÓN'
      expect(page).to have_content Hospitalization.last.starting
    end

    scenario 'sees errors when not adding required fields', js: true do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      patient = create(:patient, hospital: @hospital)
      referred_doctor = create(:referred_doctor, doctor: @admin, hospital: @hospital)

      visit patients_path
      expect(page).to have_content 'Buscar'
      expect(page).to have_current_path(patients_path)

      find('a[href="/hospitalizations"]').click
      click_link 'Registrar Hospitalización'

      click_button 'Registrar Hospitalización'

      expect(page).to have_current_path new_hospitalization_path

      expect(page).to have_content 'Fecha de ingreso no puede estar en blanco'
      expect(page).to have_content 'Fecha de egreso no puede estar en blanco'

      delete_from_combobox('#hospitalization_patient_id', patient.to_s, original: '')
      click_on_option(patient.to_s)
      expect_combobox('input[name="hospitalization[patient_id]"]', value: patient.to_param)

      delete_from_combobox('#hospitalization_referred_doctor_id', referred_doctor.to_s, original: '')
      click_on_option(referred_doctor.to_s)
      expect_combobox('input[name="hospitalization[referred_doctor_id]"]', value: referred_doctor.to_param)

      fill_up_hospitalization_form
      click_button 'Registrar Hospitalización'

      expect(page).to have_current_path hospitalization_path Hospitalization.last
      expect(page).to have_content 'INFORMACIÓN'
      expect(page).to have_content Hospitalization.last.starting
    end
  end

  def fill_up_hospitalization_form
    select 'Traslado a otra unidad', from: 'hospitalization_status'

    fill_in 'hospitalization_starting', with: DateTime.current
    fill_in 'hospitalization_ending', with: DateTime.current + 5.days

    fill_in 'hospitalization_days_of_stay', with: '5'

    fill_in_trix_editor 'hospitalization_reason_for_hospitalization', with: 'Razon de la hospitalización'
    fill_in_trix_editor 'hospitalization_treatment', with: 'Tratamiento'
    fill_in_trix_editor 'hospitalization_input_diagnosis', with: 'Diagnostico de entrada'
    fill_in_trix_editor 'hospitalization_output_diagnosis', with: 'Diagnostico de salida'
    fill_in_trix_editor 'hospitalization_recommendations', with: 'Recomendaciones'
  end
end
