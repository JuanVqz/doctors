# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Hospitals
puts "Creating Hospitals"
hospital_one = Hospital.where(name: "Primero", subdomain: "uno", description: "Una descripcion para el primer hospital.").first_or_create
hospital_two = Hospital.where(name: "Segundo", subdomain: "dos", description: "Una descripcion para el segudo hospital.").first_or_create

# Doctors
puts "Creating Doctors"
doctor_one = Doctor.create(name: "Pedro Primero", first_name: "Ramírez", last_name: "Sánchez", specialty: "Cirujano Plastico", email: "pedrouno@gmail.com", password: "123456", password_confirmation: "123456", confirmed_at: Time.now, hospital_id: hospital_one.id)
Doctor.create(name: "Pedro Segundo", first_name: "Santos", last_name: "Pérez", specialty: "Cirujano Dentista", email: "pedrodos@gmail.com", password: "123456", password_confirmation: "123456", confirmed_at: Time.now, hospital_id: hospital_two.id)

# Patients
puts "Creating Patients"
patient_one = Patient.create(name: "Marco", first_name: "Chavez", last_name: "Castro", birthday: "1989-09-19", place_of_birth: "Oaxaca de Juárez", sex: "Masculino", cellphone: "951 123 45 67", height: "180", weight: "100", blood_group: "ARH+", occupation: "Herrero", referred_by: "el Dr. Ramiro", hospital_id: hospital_one.id)
patient_two = Patient.create(name: "Ignacio", first_name: "Islas", last_name: "Miguel", birthday: "2000-09-19", place_of_birth: "Oaxaca de Juárez", sex: "Masculino", cellphone: "951 123 45 67", height: "200", weight: "100", blood_group: "ORH+", occupation: "Minero", referred_by: "el Dr. Ramiro", hospital_id: hospital_one.id)

# Address
puts "Creating Address"
Address.create(street: "Morelos", number: "8", colony: "Centro", postal_code: "68000", municipality: "Oaxaca", state: "Oaxaca", country: "México", addressable_type: "Patient", addressable: patient_one)
Address.create(street: "Benito Juárez", number: "18", colony: "Centro", postal_code: "68000", municipality: "Oaxaca", state: "Oaxaca", country: "México", addressable_type: "Patient", addressable: patient_two)


# Doctor << Paciente
puts "Doctor << Patients"
doctor_one.patients << [patient_one, patient_two]

# Doctors
puts "Creating Medical Consultations"
MedicalConsultation.create(reason: "Motivo de la consulta", subjetive: "Explicacion del malestar", objetive: "EL objetivo es curar", prescription: "Lo que se le receta al paciente", doctor: doctor_one, patient: patient_one, hospital_id: hospital_one.id)
MedicalConsultation.create(reason: "Motivo de la consulta", subjetive: "Explicacion del malestar", objetive: "EL objetivo es curar", prescription: "Lo que se le receta al paciente", doctor: doctor_one, patient: patient_two, hospital_id: hospital_one.id)
