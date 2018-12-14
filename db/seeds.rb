# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
require 'ffaker'

# Hospitals
puts "Creating Hospitals"
hospital_one = Hospital.where(
  name: "Hospital Pediatrico", subdomain: "stark-headland-73197",
  description: "Salvando Vidas", tags: "Cirugía general gastrointestinal,Cirugía con laparoscópica avanzada,Enfermedades del aparato digestivo,Clínica de hernias,Tiroides y paratiroide,Estómago,Enfermedad  por reflujo gastroesofágico,Esófago,Hígado,Vesícula biliar,Apéndice",
  about: "La fundación del Hospital Infantil de México, primero de los actuales Institutos Nacionales de Salud, dio inicio, sin duda, de la modernidad del sistema de salud en México.",
  schedule: "Lunes a Viernes de 09:00 - 19:00"
).first_or_create

Address.create(
  street: "Emiliano Zapata", number: "Int 10", colony: "Reforma",
  municipality: "Oaxaca de Juárez", addressable: hospital_one
)

# Doctors
puts "Creating Doctors"
doctor_one = Doctor.create(
  name: "Pedro", first_name: "Ramírez", last_name: "Sánchez",
  specialty: "Cirujano Plastico", email: "pedrouno@gmail.com", password: "123456",
  password_confirmation: "123456", confirmed_at: Time.now,
  hospital_id: hospital_one.id, role: "admin"
)

# Patients
puts "Creating Patients"
30.times do |n|
  puts "#{n} - 30"
  patient = Patient.create(
    name: FFaker::NameMX.name, first_name: FFaker::Name.last_name,
    last_name: FFaker::Name.last_name, birthday: "1989-09-19",
    place_of_birth: "México", sex: "Masculino",
    cellphone: FFaker::PhoneNumberMX.mobile_phone_number, height: 170,
    weight: 80, blood_group: "ARH+", occupation: "Ocupacion #{n}",
    created_at: FFaker::Time.between(10.years.ago, 2.months.ago),
    referred_by: FFaker::NameMX.name, hospital_id: hospital_one.id
  )

  Address.create(
    street: FFaker::Address.street_name, number: n,
    colony: FFaker::Address.street_name, postal_code: FFaker::AddressMX.postal_code,
    municipality: FFaker::AddressMX.municipality, state: FFaker::AddressMX.state,
    country: FFaker::Address.country, addressable_type: "Patient",
    addressable: patient
  )

  ClinicHistory.create(
    description_diabetes: FFaker::Lorem.phrase, description_hypertension: FFaker::Lorem.word,
    description_allergic: FFaker::Lorem.phrase, description_traumatic: FFaker::Lorem.word,
    description_transfusion: FFaker::Lorem.phrase, description_surgical: FFaker::Lorem.word,
    description_drug_addiction: FFaker::Lorem.phrase, description_hereditary: FFaker::Lorem.phrase,
    description_cancer: FFaker::Lorem.phrase, description_other: FFaker::Lorem.word,
    patient: patient
  )

  doctor_one.patients << patient

  (1..20).each do
    MedicalConsultation.create(
      reason: FFaker::Lorem.phrase, subjetive: FFaker::Lorem.phrase,
      objetive: FFaker::Lorem.phrase, prescription: FFaker::Lorem.phrase,
      plan: FFaker::Lorem.paragraph, diagnosis: FFaker::Lorem.paragraph,
      created_at: FFaker::Time.between(10.years.ago, 2.months.ago),
      doctor: doctor_one, patient: patient
    )

    Hospitalization.create(
      starting: "2018-12-10", ending: "2018-12-15",
      days_of_stay: 5, doctor: doctor_one,
      created_at: FFaker::Time.between(10.years.ago, 2.months.ago),
      patient: patient
    )
  end
end
