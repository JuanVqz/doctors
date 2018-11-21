require "rails_helper"

RSpec.describe "Hospitalization's flow", type: :system do
  before :each do
    create_subdomain_hospital
    visit_sign_in_doctor
    sign_in_doctor @hospital
    create_patient
    create_hospitalizations_for_patient
    visit_dash_path
    visit_patients_path
    see_patient_name
    click_link_my_hospitalizations
  end

  feature "Doctor can create a hospitalization" do
    scenario "from patient's hospitalizations" do
      click_link_new_hospitalization
      visit_new_hospitalization_with_patient_id_param
      create_new_hospitalization_with_preselected_patient
      visit_show_hospitalization
    end
  end

  feature "Doctor should look at patient's hospitalizations" do
    scenario "returns 3 hospitalizations" do
      look_at_hospitalizations_for_patient
    end
  end

  def click_link_my_hospitalizations
    click_link "Mis Hospitalizaciónes"
  end

  def click_link_new_hospitalization
    click_link "Registrar Hospitalización"
  end

  def visit_new_hospitalization_with_patient_id_param
    expect(page).to have_current_path(new_hospitalization_path(patient_id: @patient.id))
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

  def visit_show_hospitalization
    expect(page).to have_current_path hospitalization_path Hospitalization.last
    expect(page).to have_content "INFORMACIÓN DE LA HOSPITALIZACIÓN"
    expect(page).to have_content Hospitalization.last.starting
  end

  def look_at_hospitalizations_for_patient
    expect(@patient.hospitalizations.count).to eq 3
    expect(page).to have_content(/HOSPITALIZACIÓNES DE/)
    expect(page).to have_content(/2018-11-11/)
  end
end
