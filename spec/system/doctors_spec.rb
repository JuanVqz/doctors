require "rails_helper"

RSpec.describe "Doctor's flow", type: :system do
  before :each do
    create_hospital_plan_medium
  end

  feature "Visit main page with subdomain" do
    scenario "Button Iniciar sesión" do
      visit_main_page
    end
  end

  feature "Sign in doctor" do
    scenario "with valid subdomain" do
      visit_main_page
      click_link "Iniciar sesión"
      visit_sign_in_doctor
      sign_in_admin_doctor @hospital
      visit_dash_path
    end

    scenario "with invalid email" do
      visit_sign_in_doctor
      invalid_sign_in @hospital
      expect(page).to have_content "Usuario no encontrado"
    end
  end

  feature "Create new Doctor" do
    scenario "with valid data" do
      visit_main_page
      click_link "Iniciar sesión"
      visit_sign_in_doctor
      sign_in_admin_doctor @hospital
      visit_dash_path
      visit_new_doctor
      create_new_doctor "Pedro"
      visit_show_doctor
    end

    scenario "with invalid data" do
      visit_main_page
      click_link "Iniciar sesión"
      visit_sign_in_doctor
      sign_in_admin_doctor @hospital
      visit_dash_path
      visit_new_doctor
      create_new_doctor ""
      show_name_error
    end
  end

  feature "Update Doctor" do
    context "from show doctor page" do
      before :each do
        visit_main_page
        click_link "Iniciar sesión"
        visit_sign_in_doctor
        sign_in_admin_doctor @hospital
        visit_dash_path
        visit_new_doctor
        create_new_doctor "Pedro"
        visit_show_doctor
      end

      scenario "with valid data" do
        click_link "Editar"
        fill_in "doctor_name", with: "Pedro update"
        click_button "Actualizar Doctor"
        visit_show_doctor
      end
    end

    context "from index doctor page" do
      before :each do
        visit_main_page
        click_link "Iniciar sesión"
        visit_sign_in_doctor
        sign_in_admin_doctor @hospital
        visit_dash_path
        visit_new_doctor
        create_new_doctor "Pedro"
        visit_show_doctor
      end

      scenario "with valid data" do
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

  def visit_new_doctor
    click_link "Doctores"
    click_link "Registrar Doctor"
    expect(page).to have_current_path new_doctor_path
  end

  def create_new_doctor name
    fill_in "doctor_name", with: name
    fill_in "doctor_first_name", with: "Pérez"
    fill_in "doctor_last_name", with: "León"
    fill_in "doctor_specialty", with: "Médico General"
    fill_in "doctor_professional_card", with: "12345678"
    fill_in "doctor_email", with: "pedro@gmail.com"
    fill_in "doctor_password", with: "123456"
    fill_in "doctor_password_confirmation", with: "123456"

    page.execute_script("$('#doctor_hospital_id').val(#{ @hospital.id })")

    click_button "Crear Doctor"
  end

  def visit_main_page
    visit "http://ursula.lvh.me"
    expect(page).to have_content @hospital.name
    expect(page).to have_content "Iniciar sesión"
  end
end
