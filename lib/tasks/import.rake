require "csv"

namespace :import do

  namespace :rafael_aragon do
    desc "Import Patients from CSV"
    task patients: :environment do
      filename = File.join Rails.root, "lib/tasks/info/rafael_aragon/patients.csv"
      counter  = 0

      CSV.foreach(filename, headers: true) do |row|
        code           = row["0"]
        created_at     = row["1/e"].blank? ? DateTime.new : DateTime.parse(row["1/e"])
        updated_at     = row["2/e"].blank? ? DateTime.new : DateTime.parse(row["2/e"])
        name           = row["3"].blank? ? nil : row["3"].strip
        first_name     = row["4"].blank? ? "Apellido Paterno" : row["4"].strip
        last_name      = row["5"].blank? ? "Apellido Materno" : row["5"].strip
        blood_group    = row["6"].blank? ? "" : row["6"].strip
        birthday       = row["7/e"].blank? ? "19-09-1989" : row["7/e"]
        place_of_birth = row["8"].blank? ? "Oaxaca" : row["8"].strip
        height         = row["10"].blank? ? 0 : row["10"].strip
        weight         = row["11"].blank? ? 0 : row["11"].strip
        sex            = row["18"].blank? ? "" : row["18"].strip
        occupation     = row["19"].blank? ? "" : row["19"].strip
        referred_by    = row["20"].blank? ? "" : row["20"].strip

        # Address
        street = row["13/0/street"]

        # ClinicHistory
        d_diabetes       = row["37"]
        d_hypertension   = row["39"]
        d_allergic       = row["40"]
        d_traumatic      = row["41"]
        d_transfusion    = row["42"]
        d_surgical       = row["43"]
        d_drug_addiction = row["44"]
        d_cancer         = row["45"]
        d_other          = row["46"]

        if name.present?
          doctor      = Doctor.unscoped.find_by(email: "drrafaelaragon@gmail.com")
          hospital_id = doctor.hospital.id if doctor.present?

          patient = Patient.create(name: name, first_name: first_name, last_name: last_name,
           birthday: birthday, height: height, weight: weight, blood_group: blood_group,
           occupation: occupation, referred_by: referred_by, place_of_birth: place_of_birth,
           sex: sex, created_at: created_at, updated_at: updated_at, confirmed_at: Time.now,
           hospital_id: hospital_id)
          puts "#{patient.errors.full_messages.join(",")}" if patient.errors.any?

          address = Address.create(street: street, addressable_type: "Patient", addressable: patient)
          puts "#{address.errors.full_messages.join(",")}" if address.errors.any?

          clinic_history = ClinicHistory.create(description_diabetes: d_diabetes,
            description_hypertension: d_hypertension, description_allergic: d_allergic,
            description_traumatic: d_traumatic, description_transfusion: d_transfusion,
            description_surgical: d_surgical, description_drug_addiction: d_drug_addiction,
            description_cancer: d_cancer, description_other: d_other, patient: patient)
          puts "#{clinic_history.errors.full_messages.join(",")}" if clinic_history.errors.any?

          doctor.patients << patient

          # The patient that more times went to a medical consultation
          # with this Doctor was 16 times
          16.times do |n|
            medical_consultation_code = row["48/#{n}"]
            if medical_consultation_code.present?
              bento = Bento.create(code: medical_consultation_code, patient: patient)
              puts "#{bento.errors.full_messages.join(",")}" if bento.errors.any?
            end
          end

          counter += 1 if patient.persisted?
          puts "#{code} patient #{patient.id} #{patient.name}."
        else
          puts "#{code} not exists."
        end
      end

      puts "Imported #{counter} bentos."
    end

    desc "Import Medical Consultation from CSV"
    task medical_consultations: :environment do
      filename = File.join Rails.root, "lib/tasks/info/rafael_aragon/medical_consultations.csv"
      counter  = 0

      CSV.foreach(filename, headers: true) do |row|
        code           = row["0"]
        created_at     = row["1/e"].blank? ? DateTime.new : DateTime.parse(row["1/e"])
        updated_at     = row["2/e"].blank? ? DateTime.new : DateTime.parse(row["2/e"])
        subjetive      = row["3"].blank? ? nil : row["3"].strip
        objetive       = row["4"].blank? ? nil : row["4"].strip
        diagnosis      = row["5"].blank? ? nil : row["5"].strip
        plan           = row["6"].blank? ? nil : row["6"].strip
        lab_results    = row["11"].blank? ? nil : row["11"].strip
        treatment      = row["12"].blank? ? nil : row["12"].strip
        reason         = row["13"].blank? ? nil : row["13"].strip
        histopathology = row["15"].blank? ? nil : row["15"].strip
        comments       = row["16"].blank? ? nil : row["16"].strip
        prescription   = "Bento"

        bento = Bento.find_by(code: code)
        if bento
          if plan || subjetive
            doctor  = Doctor.unscoped.find_by(email: "drrafaelaragon@gmail.com")
            patient = Patient.unscoped.find(bento.patient_id)

            medical_consultation = MedicalConsultation.create(subjetive: subjetive,
              objetive: objetive, diagnosis: diagnosis, plan: plan, lab_results: lab_results,
              treatment: treatment, reason: reason, histopathology: histopathology,
              comments: comments, prescription: prescription, doctor: doctor,
              patient: patient, created_at: created_at, updated_at: updated_at)
            puts "#{medical_consultation.errors.full_messages.join(",")}" if medical_consultation.errors.any?

            counter += 1 if medical_consultation.persisted?
            puts "#{code} Patient #{patient.id} #{patient.name} has medical consultation."
          else
            puts "#{code} The medical consultation has not Patient."
          end
        else
          puts "#{code} The code not exists."
        end
      end

      puts "Imported #{counter} medical consultations."
    end
  end

end
