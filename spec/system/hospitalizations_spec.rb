require "rails_helper"

RSpec.describe "Hospitalization's flow", type: :system do
  feature "Doctor can create an hospitalization" do
    scenario "from patient list", js: true do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      create_patient doctor: @admin
      create_three_hospitalizations_for_patient doctor: @admin
      visit_patients_path
      see_patient_name
      click_link_details
      click_link_tab_hospitalizations
      click_link_new_hospitalization
      visit_new_hospitalization_with_patient_id_param
      create_new_hospitalization_with_preselected_patient
      visit_show_hospitalization
    end
  end

  def click_link_tab_hospitalizations
    find(:css, "#my_hospitalizations").click
  end

  def click_link_new_hospitalization
    click_link "Nueva Hospitalización"
  end

  def visit_new_hospitalization_with_patient_id_param
    expect(page).to have_current_path(new_hospitalization_path(patient_id: @patient.id))
  end

  def create_new_hospitalization_with_preselected_patient
    see_patient_name
    fill_in "hospitalization_starting", with: DateTime.current
    fill_in "hospitalization_ending", with: DateTime.current
    fill_in "hospitalization_days_of_stay", with: "5"
    fill_in_trix_editor "hospitalization_reason_for_hospitalization", with: "Razon de la hospitalización"
    fill_in_trix_editor "hospitalization_treatment", with: "Tratamiento"
    fill_in_trix_editor "hospitalization_input_diagnosis", with: "Diagnostico de entrada"
    fill_in_trix_editor "hospitalization_output_diagnosis", with: "Diagnostico de salida"
    fill_in_trix_editor "hospitalization_recommendations", with: "Recomendaciones"

    click_button "Crear Hospitalización"
  end

  def visit_show_hospitalization
    expect(page).to have_current_path hospitalization_path Hospitalization.last
    expect(page).to have_content "INFORMACIÓN DE LA HOSPITALIZACIÓN"
    expect(page).to have_content Hospitalization.last.starting
  end
end
