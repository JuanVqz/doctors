require "csv"

namespace :import do
  namespace :doctor_name do
    desc "Import Patients from CSV"
    task patients: :environment do
      filename = Rails.root.join("lib/tasks/info/doctor_name/patients.csv")
      counter = 0
      doctor = Doctor.unscoped.find_by(email: "doctor@gmail.com")
      hospital = Hospital.find_by(subdomain: "subdomain")

      CSV.foreach(filename, headers: true) do |row|
        puts "save patients: #{doctor}, #{hospital}"
      end
    end

    desc "Import Medical Consultation from CSV"
    task medical_consultations: :environment do
      doctor = Doctor.unscoped.find_by(email: "doctor@gmail.com")
      filename = Rails.root.join("lib/tasks/info/doctor_name/medical_consultations.csv")
      counter = 0

      CSV.foreach(filename, headers: true) do |row|
        puts "save appoinments: #{doctor}"
      end
    end
  end
end
