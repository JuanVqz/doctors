require "rails_helper"

RSpec.describe "Referred Doctor's flow", type: :system do
  before :each do
    create_hospital_plan_medium
  end

  scenario "As Admin, I can see the referred doctors list" do
    visit_subdomain_hospital_page
    click_link "Iniciar sesión"
    visit_sign_in_doctor
    sign_in_admin_doctor @hospital
    visit_referred_doctors_path
  end

  def visit_subdomain_hospital_page
    visit "http://ursula.lvh.me"
    expect(page).to have_content @hospital.name
    expect(page).to have_content "Iniciar sesión"
  end

  def visit_referred_doctors_path
    visit referred_doctors_path
  end
end
