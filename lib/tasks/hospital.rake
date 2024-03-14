namespace :hospital do
  desc "Create a relationship between appointments and hospitals"
  task import_appointments: :environment do
    hospitals = Hospital.all
    hospitals.each do |hospital|
      puts "Processing hospital: #{hospital.subdomain}"
      hospital.doctors.each do |doctor|
        puts "Processing doctor: #{doctor.name}"
        appointments = doctor.appointments
        appointments.each do |appointment|
          puts "Processing appointment: #{appointment.id} to hospital: #{hospital.subdomain}"
          appointment.hospital = hospital
          appointment.save
        end
      end
    end
  end
end
