require "csv"

namespace :import do
  desc "Import Patients from CSV"
  task patients: :environment do
    filename = File.join Rails.root, "patients.csv"
    counter = 0

    CSV.foreach(filename, headers: true) do |row|
      hospital = Hospital.first

      # Patient
      name       = row["Nombre"].blank? ? "Nombre" : row["Nombre"].strip
      first_name = row["Apellido Paterno"].blank? ? "Apellido Paterno" : row["Apellido Paterno"].strip
      last_name  = row["Apellido Materno"].blank? ? "Apellido Materno" : row["Apellido Materno"].strip
      birthday   = row["Fecha de Nacimiento"].blank? ? "19-09-1989" : row["Fecha de Nacimiento"].strip
      height     = row["Estatura"].blank? ? 0 : row["Estatura"].strip
      weight     = row["Peso"].blank? ? 0 : row["Peso"].strip
      blood_group = row["Grupo Sanguíneo"].blank? ? "" : row["Grupo Sanguíneo"].strip
      occupation = row["Ocupación"].blank? ? "" : row["Ocupación"].strip
      referred_by = row["Referido por"].blank? ? "" : row["Referido por"].strip
      place_of_birth = row["Lugar de Nacimiento"].blank? ? "19-09-1989" : row["Lugar de Nacimiento"].strip
      cellphone = row["Teléfono (Value)"].blank? ? "" : row["Teléfono (Value)"].strip
      sex = row["Sexo"].blank? ? "" : row["Sexo"].strip
      created_at = row["Date Created"].blank? ? DateTime.new : DateTime.parse(row["Date Created"])
      updated_at = row["Date Modified"].blank? ? DateTime.new : DateTime.parse(row["Date Modified"])

      # Address
      street = row["Domicilio (Street)"]
      postal_code = row["Domicilio (Zip)"]

      # ClinicHistory
      d_diabetes = row["D"]
      d_hypertension = row["H"]
      d_allergic = row["A"]
      d_traumatic = row["T"]
      d_transfusion = row["Tr"]
      d_surgical = row["Q"]
      d_drug_addiction = row["To"]
      d_hereditary = ""
      d_cancer = row["C"]
      d_other = row["O"]

      patient = Patient.create(name: name, first_name: first_name, last_name: last_name,
       birthday: birthday, height: height, weight: weight, blood_group: blood_group,
       occupation: occupation, referred_by: referred_by, place_of_birth: place_of_birth,
       cellphone: cellphone, sex: sex, created_at: created_at,
       updated_at: updated_at, confirmed_at: Time.now,
       hospital_id: hospital.id)
      puts "#{patient.errors.full_messages.join(",")}" if patient.errors.any?

      address = Address.create(street: street, postal_code: postal_code, addressable_type: "Patient", addressable: patient)
      puts "#{address.errors.full_messages.join(",")}" if address.errors.any?

      clinic_history = ClinicHistory.create(description_diabetes: d_diabetes,
        description_hypertension: d_hypertension, description_allergic: d_allergic,
        description_traumatic: d_traumatic, description_transfusion: d_transfusion,
        description_surgical: d_surgical, description_drug_addiction: d_drug_addiction,
        description_hereditary: d_hereditary, description_cancer: d_cancer,
        description_other: d_other, patient: patient)
      puts "#{clinic_history.errors.full_messages.join(",")}" if clinic_history.errors.any?

      counter += 1 if patient.persisted?
    end

    puts "Imported #{counter} patients."
  end
end
