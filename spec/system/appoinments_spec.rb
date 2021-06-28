require "rails_helper"

RSpec.describe "Medical Consultations flow", type: :system do
  before :each do
    create_hospital_plan_medium
    sign_in_admin_doctor @hospital
    create_patient
    create_three_appoinments_for_patient
    visit_patients_path
    see_patient_name
    click_link_details
  end

  feature "Doctor can create a medical consultation" do
    scenario "from patients list", js: true do
      click_link_tab_appoinments
      click_link_new_appoinment
      visit_new_appoinment_with_patient_id_param
      create_new_appoinment_with_preselected_patient
      visit_appoinment_show
    end
  end

  def click_link_tab_appoinments
    find(:css, "#appoinments").click
  end

  def click_link_new_appoinment
    click_link "Nueva Consulta"
  end

  def visit_new_appoinment_with_patient_id_param
    expect(page).to have_current_path(new_appoinment_path(patient_id: @patient.id))
  end

  def create_new_appoinment_with_preselected_patient
    see_patient_name
    fill_in "appoinment_reason", with: "Razón de la consulta"
    find(:xpath, "//*[@input='appoinment_note']", visible: false).set("Nota Medica")
    find(:xpath, "//*[@input='appoinment_prescription']", visible: false).set("Receta")
    find(:xpath, "//*[@input='appoinment_recommendations']", visible: false).set("Recomendaciones")
    fill_in "appoinment_weight", with: "80"
    fill_in "appoinment_height", with: "170"
    fill_in "appoinment_blood_pressure", with: "120/80"
    fill_in "appoinment_heart_rate", with: "89"
    fill_in "appoinment_breathing_rate", with: "10"
    fill_in "appoinment_temperature", with: "40"
    fill_in "appoinment_glycaemia", with: "0"
    fill_in "appoinment_sat_02", with: "0"
    fill_in "appoinment_cost", with: "300"
    fill_in "appoinment_cabinet_results", with: "Resultados de Laboratorio"
    fill_in "appoinment_histopathology", with: "histopatologia"

    click_button "Crear Consulta"
  end

  def visit_appoinment_show
    expect(page).to have_current_path appoinment_path Appoinment.last
    expect(page).to have_content "INFORMACIÓN DE LA CONSULTA"
    see_patient_name
  end
end
