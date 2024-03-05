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
      click_on "Registrar Paciente"

      fill_up_patient_form "Maximo"
      click_button "Registrar Paciente"

      expect(page).to have_content "DATOS GENERALES"
      expect(page).to have_content "Maximo"
    end

    scenario "see error message when patient is invalid" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      visit patients_path
      expect(page).to have_content "Buscar"

      click_on "Registrar Paciente"
      fill_up_patient_form ""
      click_button "Registrar Paciente"
      expect(page).to have_content "Nombre no puede estar en blanco"

      fill_up_patient_form "Kenia"
      click_button "Registrar Paciente"
      expect(page).to have_content "Kenia"
    end
    scenario "can edit a patient from show page with valid information" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      visit patients_path
      expect(page).to have_content "Buscar"
      click_on "Registrar Paciente"

      fill_up_patient_form "Juan"
      click_button "Registrar Paciente"

      expect(page).to have_content "Juan"

      find('a[data-tooltip="Editar"]').click
      fill_in "patient_name", with: "Juan Antonio"
      click_button "Actualizar Paciente"
      expect(page).to have_content "Juan Antonio"
    end

    scenario "can create appoinments after create the patient" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      visit patients_path
      expect(page).to have_content "Buscar"

      click_on "Registrar Paciente"
      fill_up_patient_form "Lizzette"
      click_button "Registrar Paciente"

      visit patients_path
      expect(page).to have_content "Buscar"
      patient = Patient.find_by(name: "Lizzette")

      within "tr", text: "Lizzette" do
        find('a[data-tooltip="Nueva Consulta"]').click
      end
      expect(page).to have_content "Lizzette"
      expect(find("#appoinment_patient_id").value).to eq patient.to_param
    end

    scenario "can go to the patient's appoinment history" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      patient = create(:patient, doctors: [@admin], hospital: @hospital)
      create_list(:appoinment, 3, doctor: @admin, patient: patient)

      visit patient_path(patient)
      expect(page).to have_content "DATOS GENERALES"
      find('a[data-tooltip="Consultas Previas"]').click
      expect(page).to have_content patient, count: 3
    end

    scenario "can see the patient's clinic history in the same new page", js: true do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      patient = create(:patient, pathological_background: :something, doctors: [@admin], hospital: @hospital)

      visit patients_path
      expect(page).to have_content "Buscar"

      within "tr[data-patient-id='#{patient.id}']" do
        first('a[data-tooltip="Nueva Consulta"]').click
      end

      expect(page).to have_content "HISTORIAL CLÍNICO"
      expect(page).to have_content patient.pathological_background
      expect(page).to_not have_content "CONSULTAS PREVIAS"
    end

    scenario "can see the previous patient's appoinments in the same new page", js: true do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      patient = create(:patient, doctors: [@admin], hospital: @hospital)
      create_list(:appoinment, 4, doctor: @admin, patient: patient)

      visit patients_path
      expect(page).to have_content "Buscar"

      within "tr[data-patient-id='#{patient.id}']" do
        first('a[data-tooltip="Nueva Consulta"]').click
      end

      expect(page).to have_content "CONSULTAS PREVIAS"
      expect(page).to have_selector "details", count: 3
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
