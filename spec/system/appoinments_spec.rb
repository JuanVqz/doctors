require "rails_helper"

RSpec.describe "Medical Consultations flow", type: :system do
  before do
    driven_by(:headless_firefox)
  end

  feature "Doctor creates an appoinment" do
    scenario "from the show page" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      @patient = create(:patient)

      visit patients_path
      expect(page).to have_content "Buscar"
      expect(page).to have_current_path(patients_path)

      within "tr[data-patient-id='#{@patient.id}']" do
        find('a[data-tooltip="Detalles"]').click
      end

      find('a[data-tooltip="Nueva Consulta"]').click
      expect(page).to have_current_path(new_appoinment_path(patient_id: @patient.id))

      fill_up_appoinment_form
      click_button "Registrar Consulta"

      expect(page).to have_current_path appoinment_path Appoinment.last
      expect(page).to have_content "CONSULTA ##{Appoinment.last.id}"
      expect(page).to have_content(/#{@patient}/)
    end

    scenario "for the correct patient even when the name is almost the same" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      @other_patient = create(:patient, name: "Zác", doctors: [@admin])
      @patient = create(:patient, name: "Zac", doctors: [@admin])

      visit patients_path
      expect(page).to have_content "Buscar"
      expect(page).to have_current_path(patients_path)

      first('a[data-tooltip="Nueva Consulta"]').click
      expect(page).to have_current_path new_appoinment_path(patient_id: @patient.id)

      click_button "Registrar Consulta"
      expect(page).to have_current_path appoinments_path

      fill_up_appoinment_form
      click_button "Registrar Consulta"

      last_appoinment = Appoinment.last
      expect(page).to have_current_path appoinment_path last_appoinment
      expect(page).to have_content "CONSULTA ##{last_appoinment.id}"
      expect(page).to have_content(/#{@patient}/)

      within "main" do
        expect(page).to have_no_content @other_patient.to_s
        expect(page).to have_content @patient.to_s
      end
    end
  end

  def fill_up_appoinment_form
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
  end
end
