# frozen_string_literal: true

require 'rails_helper'

RSpec.describe "Patient Referrals' flow", type: :system do
  before do
    driven_by(:headless_firefox)
  end

  feature 'Doctor' do
    scenario 'can create a patient referral' do
      create_hospital_plan_medium
      sign_in_admin_doctor @hospital
      patient = create(:patient, hospital: @hospital)
      referred_doctor = create(:referred_doctor, doctor: @admin, hospital: @hospital)

      visit new_patient_referral_path
      expect(page).to have_current_path new_patient_referral_path
      fill_form_up
      click_button 'Referir Paciente'

      expect(page).to have_content 'Destinatario no puede estar vacío'
      expect(page).to have_content 'Paciente no puede estar vacío'

      delete_from_combobox('#patient_referral_referred_doctor_id', referred_doctor.to_s, original: '')
      click_on_option(referred_doctor.to_s)
      expect_combobox('input[name="patient_referral[referred_doctor_id]"]', value: referred_doctor.to_param)

      delete_from_combobox('#patient_referral_patient_id', patient.to_s, original: '')
      click_on_option(patient.to_s)
      expect_combobox('input[name="patient_referral[patient_id]"]', value: patient.to_param)

      click_button 'Referir Paciente'

      expect(page).to have_content 'Referencia del paciente creada correctamente.'
      @patient_referral = PatientReferral.last
      expect(page).to have_content @patient_referral.subject
      expect(page).to have_content @patient_referral.patient
      expect(page).to have_content @patient_referral.doctor
      expect(page).to have_content @patient_referral.referred_doctor
    end
  end

  def fill_form_up
    fill_in 'patient_referral_subject', with: 'Le da el tramafa'
    fill_in_trix_editor 'patient_referral_content', with: 'Le envio a este paciente porque le da el tramafa'
  end
end
