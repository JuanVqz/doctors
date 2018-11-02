module Feature
  module AuthenticationHelpers
    def sign_in_doctor hospital
      doctor = create :doctor, hospital: hospital
      visit new_user_session_path
      fill_in "user_email", with: doctor.email
      fill_in "user_password", with: doctor.password
      click_button "Iniciar Sesión"
    end

    def invalid_sign_in hospital
      doctor = create :doctor, hospital: hospital
      fill_in "user_email", with: "invalid@gmail.com"
      fill_in "user_password", with: doctor.password
      click_button "Iniciar Sesión"
    end
  end
end
