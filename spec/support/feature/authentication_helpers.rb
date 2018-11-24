module Feature
  module AuthenticationHelpers
    def sign_in_doctor hospital
      @doctor = create :doctor, hospital: hospital, role: "doctor"
      visit new_user_session_path
      fill_in "user_email", with: @doctor.email
      fill_in "user_password", with: @doctor.password
      click_button "Iniciar Sesión"
    end

    def sign_in_admin_doctor hospital
      @doctor = create :doctor, hospital: hospital, role: "admin"
      visit new_user_session_path
      fill_in "user_email", with: @doctor.email
      fill_in "user_password", with: @doctor.password
      click_button "Iniciar Sesión"
    end

    def visit_sign_in_doctor
      visit new_user_session_path
      expect(page).to have_current_path(new_user_session_path)
    end

    def visit_dash_path
      expect(page).to have_current_path(dash_path)
    end

    def invalid_sign_in hospital
      doctor = create :doctor, hospital: hospital
      fill_in "user_email", with: "invalid@gmail.com"
      fill_in "user_password", with: doctor.password
      click_button "Iniciar Sesión"
    end
  end
end
