require "rails_helper"

RSpec.describe "Hospitalization's flow", type: :system do
  before do
    driven_by(:headless_firefox)
  end

  feature "Doctor" do
    scenario "can create an hospitalization from patient list" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      patient = create(:patient, hospital: @hospital)
      referred_doctor = create(:referred_doctor, doctor: @admin, hospital: @hospital)

      visit patients_path
      expect(page).to have_content "Buscar"
      expect(page).to have_current_path(patients_path)

      within "tr[data-patient-id='#{patient.id}']" do
        find('a[data-tooltip="Detalles"]').click
      end

      find('a[data-tooltip="Nueva Hospitalización"]').click
      expect(page).to have_current_path(new_hospitalization_path(patient_id: patient.id))
      fill_up_hospitalization_form(patient, referred_doctor)
      click_button "Registrar Hospitalización"

      expect(page).to have_current_path hospitalization_path Hospitalization.last
      expect(page).to have_content "INFORMACIÓN"
      expect(page).to have_content Hospitalization.last.starting
    end

    scenario "sees errors when not adding required fields" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      patient = create(:patient, hospital: @hospital)
      referred_doctor = create(:referred_doctor, doctor: @admin, hospital: @hospital)

      visit patients_path
      expect(page).to have_content "Buscar"
      expect(page).to have_current_path(patients_path)

      find('a[href="/hospitalizations"]').click
      click_link "Registrar Hospitalización"

      click_button "Registrar Hospitalización"

      expect(page).to have_current_path new_hospitalization_path
      expect(page).to have_content "Paciente no puede estar en blanco"
      expect(page).to have_content "Fecha de ingreso no puede estar en blanco"

      select patient.to_s, from: "hospitalization_patient_id"
      fill_up_hospitalization_form(patient, referred_doctor)
      click_button "Registrar Hospitalización"

      expect(page).to have_current_path hospitalization_path Hospitalization.last
      expect(page).to have_content "INFORMACIÓN"
      expect(page).to have_content Hospitalization.last.starting
    end
  end

  def fill_up_hospitalization_form(patient, referred_doctor)
    expect(page).to have_content(/#{patient}/)

    select "Traslado a otra unidad", from: "hospitalization_status"
    select referred_doctor.to_s, from: "hospitalization_referred_doctor_id" if referred_doctor

    # hospitalization_starting
    # day
    select "1", from: :hospitalization_starting_3i
    # month
    select "enero", from: :hospitalization_starting_2i
    # year
    select "2021", from: :hospitalization_starting_1i

    # hospitalization_ending
    # day
    select "5", from: :hospitalization_ending_3i
    # month
    select "enero", from: :hospitalization_ending_2i
    # year
    select "2021", from: :hospitalization_ending_1i

    fill_in "hospitalization_days_of_stay", with: "5"

    fill_in_trix_editor "hospitalization_reason_for_hospitalization", with: "Razon de la hospitalización"
    fill_in_trix_editor "hospitalization_treatment", with: "Tratamiento"
    fill_in_trix_editor "hospitalization_input_diagnosis", with: "Diagnostico de entrada"
    fill_in_trix_editor "hospitalization_output_diagnosis", with: "Diagnostico de salida"
    fill_in_trix_editor "hospitalization_recommendations", with: "Recomendaciones"
  end
end
