module Feature
  module PatientMethodsHelpers
    def visit_patients_path
      click_link "Pacientes"
      expect(page).to have_content "PACIENTES"
    end

    def create_patient
      @patient = create :patient, name: "Marco", doctors: [@doctor]
    end

    def see_patient_name
      expect(page).to have_content(/#{@patient}/)
    end
  end
end
