module Feature
  module PatientMethodsHelpers
    def visit_patients
      click_link "Pacientes"
      expect(page).to have_content "PACIENTES"
    end
  end
end
