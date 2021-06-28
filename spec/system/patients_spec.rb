require "rails_helper"

RSpec.describe "Patient's flow", type: :system do
  feature "Doctor can create a patient" do
    scenario "with valid data", js: true do
      create_hospital_plan_medium
      sign_in_doctor @hospital
      visit_patients_path
      visit_new_patient
      create_new_patient "Marco"
      visit_show_patient
    end

    scenario "with invalid data", js: true do
      create_hospital_plan_medium
      sign_in_doctor @hospital
      visit_patients_path
      visit_new_patient
      create_new_patient ""
      expect(page).to have_content "Nombre no puede estar en blanco"
    end
  end

  feature "Doctor can edit a patient" do
    context "from show patient page" do
      scenario "with valid data", js: true do
        create_hospital_plan_medium
        sign_in_doctor @hospital
        visit_patients_path
        visit_new_patient
        create_new_patient "Marco"
        visit_show_patient
        click_link "Editar"
        fill_in "patient_name", with: "Marco update"
        click_button "Actualizar Paciente"
        visit_show_patient
      end
    end
  end

  feature "Doctor can create an appoinment" do
    context "from patients#index" do
      scenario "redirect to new appoinment", js: true do
        create_hospital_plan_medium
        sign_in_doctor @hospital
        visit_patients_path
        visit_new_patient
        create_new_patient "Marco"
        visit_patients_path
        find('a[data-tooltip="Nueva consulta"]').click
        expect(page).to have_content "REGISTRAR CONSULTA"
        expect(page).to have_content "Marco"
      end
    end
  end

  def visit_show_patient
    expect(page).to have_current_path patient_path Patient.unscoped.last
    expect(page).to have_content "INFORMACIÓN DEL PACIENTE"
  end

  def create_new_patient name
    fill_in "patient_name", with: name
    fill_in "patient_first_name", with: "Chavez"
    fill_in "patient_last_name", with: "Castro"
    fill_in "patient_birthday", with: DateTime.current
    fill_in "patient_height", with: 180
    fill_in "patient_weight", with: 100
    # TODO: get it working again
    # find("#patient_blood_group").find(:xpath, "option[2]").select_option
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

    find("#patient_address_attributes_state").find(:xpath, "option[2]").select_option

    click_button "Crear Paciente"
  end

  def visit_new_patient
    click_link "Registrar Paciente"
    expect(page).to have_content "REGISTRAR PACIENTE"
  end

end
