require "rails_helper"

RSpec.describe "Patient's flow", type: :system do
  before do
    driven_by(:headless_firefox)
  end

  feature "Doctor" do
    scenario "can create a patient with valid information" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      visit patients_path
      expect(page).to have_content "Buscar"
      expect(page).to have_current_path(patients_path)
      click_on "Registrar Paciente"
      fill_up_patient_form "Marco"
      click_button "Registrar Paciente"
      expect(page).to have_current_path patient_path @hospital.patients.last
      expect(page).to have_content "DATOS GENERALES"
    end

    scenario "does not not create a patient with invalid information" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      visit patients_path
      expect(page).to have_content "Buscar"
      expect(page).to have_current_path(patients_path)
      click_on "Registrar Paciente"
      fill_up_patient_form ""
      click_button "Registrar Paciente"
      expect(page).to have_content "Nombre no puede estar en blanco"
    end
    scenario "can edit a patient from show page with valid information" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      visit patients_path
      expect(page).to have_content "Buscar"
      expect(page).to have_current_path(patients_path)
      click_on "Registrar Paciente"
      fill_up_patient_form "Marco"
      click_button "Registrar Paciente"
      expect(page).to have_current_path patient_path @hospital.patients.last
      expect(page).to have_content "DATOS GENERALES"

      find("a[data-tooltip=Editar]").click
      fill_in "patient_name", with: "Marco update"
      click_button "Actualizar Paciente"
      expect(page).to have_current_path patient_path @hospital.patients.last
      expect(page).to have_content "DATOS GENERALES"
    end

    scenario "can create an appoinment from patient#index and redirect to new appoinment" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      visit patients_path
      expect(page).to have_content "Buscar"
      expect(page).to have_current_path(patients_path)
      click_on "Registrar Paciente"
      fill_up_patient_form "Marco"
      click_button "Registrar Paciente"

      visit patients_path
      expect(page).to have_content "Buscar"
      expect(page).to have_current_path(patients_path)
      find('a[data-tooltip="Nueva Consulta"]').click
      expect(page).to have_content "REGISTRAR CONSULTA"
      expect(page).to have_content "Marco"
    end
  end

  def fill_up_patient_form name
    fill_in "patient_name", with: name
    fill_in "patient_first_name", with: "Chavez"
    fill_in "patient_last_name", with: "Castro"

    select "1", from: :patient_birthday_3i
    select "enero", from: :patient_birthday_2i
    select "1990", from: :patient_birthday_1i

    fill_in "patient_height", with: 180
    fill_in "patient_weight", with: 100
    select "ARH+", from: "patient_blood_group"
    fill_in "patient_occupation", with: "Herrero"
    fill_in "patient_referred_by", with: "Pedro Ramos"

    fill_in "patient_allergies", with: "Alergico a la penicilina"
    fill_in "patient_pathological_background", with: "Patologico"
    fill_in "patient_non_pathological_background", with: "No Patologico"
    fill_in "patient_gyneco_obstetric_background", with: "Gineco-Obstetra"
    fill_in "patient_system_background", with: "Interrogatorio por aparatos y sistemas"

    fill_in "patient_address_attributes_street", with: "Cuahutemoc"
    fill_in "patient_address_attributes_number", with: "12"
    fill_in "patient_address_attributes_colony", with: "Centro"
    fill_in "patient_address_attributes_postal_code", with: "68000"
    fill_in "patient_address_attributes_municipality", with: "Oaxaca"

    find_by_id("patient_address_attributes_state").find(:xpath, "option[2]").select_option
  end
end
