require 'ffaker'

# Hospitals
puts "Creating Hospitals"
fake_hospitals = [
  {
    name: "Hospital Pediatrico", subdomain: "stark-headland-73197",
    description: "Salvando Vidas", tags: "Cirugía, Especialistas",
    about: "La fundación del Hospital Infantil de México",
    schedule: "Lunes a Viernes de 09:00 - 19:00"
  },{
    name: "Hospital Gastroenterologia", subdomain: "rafaelaragon",
    description: "Salvando Vidas", tags: "Cirugía, Especialistas",
    about: "La fundación del Hospital Infantil de México",
    schedule: "Lunes a Viernes de 09:00 - 19:00"
  }, {
    name: "Hospital Ginecologia", subdomain: "carloscervantes",
    description: "Salvando Vidas", tags: "Cirugía, Especialistas",
    about: "La fundación del Hospital Infantil de México",
    schedule: "Lunes a Viernes de 09:00 - 19:00"
  }
]

hospitals = Hospital.create(fake_hospitals)
puts "Hospitals #{hospitals.size}"

hospitals.each do |hospital|
  Address.create(
    street: "Emiliano Zapata", number: "Int 10", colony: "Reforma",
    municipality: "Oaxaca de Juárez", addressable: hospital
  )
end

# Doctors
puts "Creating Doctors"
fake_doctors = [
  {
    name: "Pedro", first_name: "Ramírez", last_name: "Sánchez",
    specialty: "Cirujano Plastico", email: "pedrouno@gmail.com",
    password: "123456", password_confirmation: "123456", confirmed_at: Time.now,
    hospital_id: Hospital.find_by(subdomain: "stark-headland-73197").id,
    role: "admin"
  }, {
    name: "Rafael", first_name: "Aragon", last_name: "Soto",
    specialty: "Cirujano Plastico", email: "drrafaelaragon@gmail.com",
    password: "123456", password_confirmation: "123456", confirmed_at: Time.now,
    hospital_id: Hospital.find_by(subdomain: "rafaelaragon").id, role: "admin"
  }, {
    name: "Carlos", first_name: "Cervantes", last_name: "Garcia",
    specialty: "Cirujano Plastico", email: "carpo123@gmail.com",
    password: "123456", password_confirmation: "123456", confirmed_at: Time.now,
    hospital_id: Hospital.find_by(subdomain: "carloscervantes").id, role: "admin"
  }
]

doctors = Doctor.create(fake_doctors)
puts "Doctors #{doctors.size}"

# Patients
puts "Creating Patients"
10.times do |n|
  puts "#{n} - 10"
  patient = Patient.create(
    name: FFaker::NameMX.name, first_name: FFaker::Name.last_name,
    last_name: FFaker::Name.last_name, birthday: "1989-09-19",
    place_of_birth: "México", sex: "Masculino",
    cellphone: FFaker::PhoneNumberMX.mobile_phone_number, height: 170,
    weight: 80, blood_group: "ARH+", occupation: "Ocupacion #{n}",
    created_at: FFaker::Time.between(10.years.ago, 2.months.ago),
    referred_by: FFaker::NameMX.name, hospital_id: Hospital.first.id
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

  doctor = Doctor.unscoped.first
  doctor.patients << patient

  (1..10).each do
    MedicalConsultation.create(
      reason: FFaker::Lorem.phrase, subjetive: FFaker::Lorem.phrase,
      objetive: FFaker::Lorem.phrase, prescription: FFaker::Lorem.phrase,
      plan: FFaker::Lorem.paragraph, diagnosis: FFaker::Lorem.paragraph,
      created_at: FFaker::Time.between(10.years.ago, 2.months.ago),
      doctor: doctor, patient: patient
    )
  end
end
