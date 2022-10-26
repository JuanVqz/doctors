require "rails_helper"

RSpec.describe "Doctor's flow" do
  before do
    driven_by(:selenium_chrome_headless)
  end

  feature "Sign in doctor" do
    scenario "with valid subdomain" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      visit_patients_path
    end

    # scenario "with invalid email" do
    #   create_hospital_plan_medium
    #   visit new_user_session_path
    #   expect(page).to have_current_path(new_user_session_path)
    #   invalid_sign_in @hospital
    #   expect(page).to have_content "Usuario no encontrado"
    # end
  end

  feature "Create new Doctor" do
    scenario "with valid data" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      create_new_doctor "Pedro"
      visit_show_doctor
    end

    scenario "with invalid data" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      create_new_doctor ""
      show_name_error
    end
  end

  feature "Update Doctor" do
    context "from show doctor page" do
      scenario "with valid data" do
        create_hospital_plan_medium
        sign_in_admin_doctor @hospital
        create_new_doctor "Pedro"
        visit_show_doctor
        click_link "Editar"
        fill_in "doctor_name", with: "Pedro update"
        click_button "Actualizar Doctor"
        visit_show_doctor
      end
    end

    context "from index doctor page" do
      scenario "with valid data" do
        create_hospital_plan_medium
        sign_in_admin_doctor @hospital
        create_new_doctor "Pedro"
        visit_show_doctor
        visit edit_doctor_path Doctor.last
        fill_in "doctor_name", with: "Pedro update"
        click_button "Actualizar Doctor"
        visit_show_doctor
      end
    end
  end

  def visit_edit_doctor
    click_link "Doctores"
    click_link "Registrar Doctor"
  end

  def show_name_error
    expect(page).to have_content "Nombre no puede estar en blanco"
  end

  def visit_show_doctor
    expect(page).to have_current_path doctor_path Doctor.last
    expect(page).to have_content Doctor.last.specialty
    expect(page).to have_content "INFORMACIÓN DEL DOCTOR"
  end

  def create_new_doctor name
    visit new_doctor_path
    expect(page).to have_current_path new_doctor_path

    fill_in "doctor_name", with: name
    fill_in "doctor_first_name", with: "Pérez"
    fill_in "doctor_last_name", with: "León"
    fill_in "doctor_specialty", with: "Médico General"
    fill_in "doctor_professional_card", with: "12345678"
    fill_in "doctor_email", with: "pedro@gmail.com"
    fill_in "doctor_password", with: "123456"
    fill_in "doctor_password_confirmation", with: "123456"

    page.execute_script("$('#doctor_hospital_id').val(#{@hospital.id})")
    page.execute_script("$('#doctor_role').val('doctor')")

    click_button "Crear Doctor"
  end
end
