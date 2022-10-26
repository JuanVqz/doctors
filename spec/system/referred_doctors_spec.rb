require "rails_helper"

RSpec.describe "Referred Doctor's flow" do
  before do
    driven_by(:selenium_chrome_headless)
  end

  feature "Referred Doctor's Flow" do
    scenario "create a new referred doctor" do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      when_i_submit_a_referred_doctor_form
      then_i_should_see_the_new_referred_doctor_information
    end
  end

  def when_i_submit_a_referred_doctor_form
    visit new_referred_doctor_path
    expect(page).to have_current_path new_referred_doctor_path
    when_i_fill_in_the_fields
    click_button "Crear Doctor"
  end

  def when_i_fill_in_the_fields
    fill_in "referred_doctor_full_name", with: "Licha Perez"
    fill_in "referred_doctor_specialty", with: "Odontólogo General"
    fill_in "referred_doctor_address_attributes_street", with: "Independencia"
    fill_in "referred_doctor_address_attributes_number", with: "19"
    fill_in "referred_doctor_address_attributes_colony", with: "Centro"
    fill_in "referred_doctor_address_attributes_postal_code", with: "12345"
    fill_in "referred_doctor_address_attributes_municipality", with: "Centro"
  end

  def then_i_should_see_the_new_referred_doctor_information
    expect(page).to have_content "Doctor fue creado correctamente."
    @last_referred_doctor = ReferredDoctor.last
    expect(page).to have_content @last_referred_doctor.full_name
    expect(page).to have_content @last_referred_doctor.specialty
    expect(page).to have_current_path referred_doctor_path @last_referred_doctor
  end
end
