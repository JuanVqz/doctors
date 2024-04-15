# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Referred Doctor's flow", type: :system do
  before do
    driven_by(:headless_firefox)
  end

  feature 'Doctor' do
    scenario 'can create a referred doctor' do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital

      visit new_referred_doctor_path
      expect(page).to have_current_path new_referred_doctor_path
      fill_up_referred_doctor_form
      click_button 'Registrar Doctor'

      @last_referred_doctor = ReferredDoctor.last
      expect(page).to have_content @last_referred_doctor.full_name
      expect(page).to have_content @last_referred_doctor.specialty
      expect(page).to have_current_path referred_doctor_path @last_referred_doctor
    end
  end

  def fill_up_referred_doctor_form
    fill_in 'referred_doctor_full_name', with: 'Licha Perez'
    fill_in 'referred_doctor_specialty', with: 'Odontólogo General'
    fill_in 'referred_doctor_address_attributes_street', with: 'Independencia'
    fill_in 'referred_doctor_address_attributes_number', with: '19'
    fill_in 'referred_doctor_address_attributes_colony', with: 'Centro'
    fill_in 'referred_doctor_address_attributes_postal_code', with: '12345'
    fill_in 'referred_doctor_address_attributes_municipality', with: 'Centro'
  end
end
