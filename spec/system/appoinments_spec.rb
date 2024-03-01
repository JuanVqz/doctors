require "rails_helper"

RSpec.describe "Medical Consultations flow", type: :system do
  before do
    driven_by(:headless_firefox)
  end

  feature "Doctor" do
    scenario "creates an appoinment from the show page" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      @patient = create(:patient)

      visit patients_path
      expect(page).to have_content "Buscar"
      within "tr[data-patient-id='#{@patient.id}']" do
        find('a[data-tooltip="Detalles"]').click
      end

      find('a[data-tooltip="Nueva Consulta"]').click

      fill_up_appoinment_form(@patient.to_param)
      click_button "Registrar Consulta"

      expect(page).to have_content "CONSULTA ##{Appoinment.last.id}"
    end

    scenario "creates an appoinment for the correct patient even when the name is almost the same" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      @other_patient = create(:patient, name: "Zác", doctors: [@admin])
      @patient = create(:patient, name: "Zac", doctors: [@admin])

      visit patients_path
      expect(page).to have_content "Buscar"
      within "tr[data-patient-id='#{@other_patient.id}']" do
        first('a[data-tooltip="Nueva Consulta"]').click
      end

      fill_up_appoinment_form(@other_patient.to_param)
      click_button "Registrar Consulta"

      expect(page).to have_content "CONSULTA ##{Appoinment.last.id}"
      expect(page).to have_content(/#{@other_patient}/)

      within "main" do
        expect(page).to have_no_content @patient
        expect(page).to have_content @other_patient
      end
    end

    scenario "can action some pages", js: true do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      patient = create(:patient, doctors: [@admin])
      appoinment = create(:appoinment, patient: patient, doctor: @admin)

      visit appoinments_path(appoinment)
      find('a[data-tooltip="Editar"]').click
      expect(page).to have_content "ACTUALIZAR CONSULTA"
      expect(find("#appoinment_patient_id").value).to eq patient.to_param

      visit appoinment_path(appoinment)
      find('a[data-tooltip="Nueva Consulta"]').click
      expect(page).to have_content "REGISTRAR CONSULTA"
      expect(find("#appoinment_patient_id").value).to eq patient.to_param

      visit appoinment_path(appoinment)
      find('a[data-tooltip="Nueva Hospitalización"]').click
      expect(page).to have_content "REGISTRAR HOSPITALIZACIÓN"
      expect(find("#hospitalization_patient_id").value).to eq patient.to_param
    end
  end

  def fill_up_appoinment_form(patient_id)
    expect(find("#appoinment_patient_id").value).to eq patient_id
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
