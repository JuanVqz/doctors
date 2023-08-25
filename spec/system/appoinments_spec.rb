require "rails_helper"

RSpec.describe "Medical Consultations flow" do
  before do
    driven_by(:selenium_chrome_headless)
  end

  xfeature "Doctor can create a medical consultation" do
    scenario "from patients list" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      create_patient doctors: [@admin]
      create_three_appoinments_for_patient doctor: @admin
      visit_patients_path
      see_patient_name
      click_link_details
      click_link_tab_appoinments
      click_link_new_appoinment
      visit_new_appoinment_with_patient_id_param
      create_new_appoinment_with_preselected_patient
      visit_appoinment_show
    end
  end

  xfeature "when the doctor doesn't enter a required field and an error is throw the patient is changed (it shouldn't) to the first patient" do
    scenario "from patients list", :js do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      create_another_patient
      create_patient name: "Zac", doctors: [@admin]
      visit_patients_path
      click_first_new_appoinment
      expect(page).to have_current_path new_appoinment_path(patient_id: @patient.id)
      when_i_submit_the_form
      expect(page).to have_current_path appoinments_path
      create_new_appoinment_with_preselected_patient
      visit_appoinment_show
      within "td#appoinment-patient" do
        expect(page).to have_no_content @other_patient.to_s
        expect(page).to have_content @patient.to_s
      end
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

    when_i_submit_the_form
  end

  def when_i_submit_the_form
    click_button "Crear Consulta"
  end

  def visit_appoinment_show
    expect(page).to have_current_path appoinment_path Appoinment.last
    expect(page).to have_content "INFORMACIÓN DE LA CONSULTA"
    see_patient_name
  end

  def create_another_patient
    @other_patient = create_patient name: "Stefani", doctors: [@admin]
  end

  def click_first_new_appoinment
    first('a[data-tooltip="Nueva consulta"]').click
  end
end
