# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Hospitals
puts "Creating Hospitals"
hospital_one = Hospital.where(name: "Heroku", subdomain: "stark-headland-73197", description: "Una descripcion para el primer hospital.").first_or_create
hospital_two = Hospital.where(name: "Segundo", subdomain: "dos", description: "Una descripcion para el segudo hospital.").first_or_create

# Doctors
puts "Creating Doctors"
Doctor.create(name: "Pedro", first_name: "Ramírez", last_name: "Sánchez", specialty: "Cirujano Plastico", email: "pedrouno@gmail.com", password: "123456", password_confirmation: "123456", confirmed_at: Time.now, hospital_id: hospital_one.id, role: "admin")
Doctor.create(name: "José", first_name: "Mendieta", last_name: "Pérez", specialty: "Cirujano Dentista", email: "jose@gmail.com", password: "123456", password_confirmation: "123456", confirmed_at: Time.now, hospital_id: hospital_one.id)
Doctor.create(name: "Juan", first_name: "Santos", last_name: "Pérez", specialty: "Cirujano Dentista", email: "juan@gmail.com", password: "123456", password_confirmation: "123456", confirmed_at: Time.now, hospital_id: hospital_two.id)

# Patients
#puts "Creating Patients"
#patients = [
  #["Marco", "1989-09-19", "ARH+"],
  #["Eduardo", "1969-01-09", "ARH+"],
  #["Ramon", "2009-03-12", "ARH+"],
  #["Guirnaldo", "1979-06-10", "ARH+"],
  #["José", "1989-08-14", "ARH+"],
  #["Abraham", "1999-09-16", "ORH+"],
  #["Mario", "1979-02-18", "ARH+"],
  #["Alfonso", "1959-05-12", "ARH-"],
  #["Isac", "2005-04-14", "ARH+"],
  #["Carlos", "2004-09-16", "ARH+"],
  #["Oscar", "1999-01-11", "ORH+"],
  #["Uriel", "1950-04-21", "ARH+"],
  #["Jeff", "2001-09-13", "ORH-"],
  #["Taylor", "2004-03-19", "ORH-"],
  #["Melvin", "2003-02-17", "ORH-"],
  #["Yoeman", "2002-05-15", "ORH-"],
  #["Gabriel", "2005-08-09", "ORH-"],
  #["David", "1960-02-25", "ORH-"],
  #["Isidro", "1956-09-28", "ORH-"],
#]

#patients.each do |name, birthday, blood_group|
  #patient = Patient.create(name: name, first_name: "Chavez", last_name: "Castro", birthday: birthday, place_of_birth: "Oaxaca de Juárez", sex: "Masculino", cellphone: "951 123 45 67", height: "180", weight: "100", blood_group: blood_group, occupation: "Herrero", referred_by: "El Dr. Ramiro", hospital_id: hospital_one.id)

  #Address.create(street: "Morelos", number: "8", colony: "Centro", postal_code: "68000", municipality: "Oaxaca", state: "Oaxaca", country: "México", addressable_type: "Patient", addressable: patient)

  #ClinicHistory.create(description_diabetes: "Razón de la diabetes", patient: patient)

  #doctor_one.patients << patient

  #(1..4).each do
    #MedicalConsultation.create(reason: "Motivo de la consulta", subjetive: "Explicacion del malestar", objetive: "EL objetivo es curar", prescription: "Lo que se le receta al paciente", doctor: doctor_one, patient: patient)

    #Hospitalization.create(starting: "2018-11-15", ending: "2018-11-20", days_of_stay: 5, doctor: doctor_one, patient: patient)
  #end
#end

