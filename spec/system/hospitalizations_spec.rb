require "rails_helper"

RSpec.describe "Hospitalization's flow", type: :system do
  before :each do
    create_subdomain_hospital
    visit_sign_in_doctor
    sign_in_doctor @hospital
    create_patient
    visit_dash_path
    visit_patients_path
  end

  feature "Doctor can create a hospitalization" do
    scenario "from patients list" do
      see_patient_name
      click_new_hospitalization
      visit_new_hospitalization_with_patient_id_param
      create_new_hospitalization_with_preselected_patient
      visit_show_hospitalization
    end
  end

  def visit_show_hospitalization
    expect(page).to have_current_path hospitalization_path Hospitalization.last
    expect(page).to have_content "INFORMACIÓN DE LA HOSPITALIZACIÓN"
    expect(page).to have_content Hospitalization.last.starting
  end

  def create_new_hospitalization_with_preselected_patient
    see_patient_name
    fill_in "hospitalization_starting", with: "11-11-2018"
    fill_in "hospitalization_ending", with: "15-11-2018"
    fill_in "hospitalization_days_of_stay", with: "5"
    fill_in "hospitalization_reason_for_hospitalization", with: "Razon de la hospitalización"
    fill_in "hospitalization_treatment", with: "Tratamiento"

    click_button "Crear Hospitalización"
  end

  def visit_new_hospitalization_with_patient_id_param
    expect(page).to have_current_path(new_hospitalization_path(patient_id: @patient.id))
  end

  def click_new_hospitalization
    click_link "Nueva Hospitalización"
  end
end
