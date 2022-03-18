require "ffaker"

puts "Creating Hospitals"
fake_hospitals = [
  {
    name: "Hospital Pediatrico", subdomain: "stark-headland-73197",
    description: "Salvando Vidas", tags: "Cirugía, Especialistas",
    about: "La fundación del Hospital Infantil de México",
    schedule: "Lunes a Viernes de 09:00 - 19:00"
  }, {
    name: "Hospital Gastroenterologia", subdomain: "rafaelaragon",
    description: "Salvando Vidas", tags: "Cirugía, Especialistas",
    about: "La fundación del Hospital Infantil de México",
    schedule: "Lunes a Viernes de 09:00 - 19:00"
  }, {
    name: "Hospital Ginecologia", subdomain: "carloscervantes",
    description: "Salvando Vidas", tags: "Cirugía, Especialistas",
    about: "La fundación del Hospital Infantil de México",
    schedule: "Lunes a Viernes de 09:00 - 19:00"
  }, {
    name: "Sto Domingo de Guzmán", subdomain: "edgardogonzalez",
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
  }, {
    name: "Edgardo", first_name: "Gonzalez", last_name: "Ramos",
    specialty: "Cirujano Plastico", email: "ramos.surgery@gmail.com",
    password: "123456", password_confirmation: "123456", confirmed_at: Time.now,
    hospital_id: Hospital.find_by(subdomain: "edgardogonzalez").id, role: "admin"
  }
]

doctors = Doctor.create(fake_doctors)
puts "Doctors #{doctors.size}"

puts "Creating Patients"
doctors.each do |doctor|
  puts "======================================================================="
  puts "Doctor: #{doctor.name} ID: #{doctor.id} Hospital: #{doctor.hospital} ID: #{doctor.hospital_id}"
  10.times do |n|
    puts "#{n} - 10"
    patient = Patient.create(
      name: FFaker::NameMX.name,
      first_name: FFaker::Name.last_name,
      last_name: FFaker::Name.last_name,
      birthday: "1989-09-19",
      place_of_birth: "México",
      sex: "Masculino",
      cellphone: FFaker::PhoneNumberMX.mobile_phone_number,
      height: 170,
      weight: 80,
      blood_group: "ARH+",
      occupation: "Ocupacion #{n}",
      allergies: FFaker::Lorem.word,
      pathological_background: FFaker::Lorem.phrase,
      non_pathological_background: FFaker::Lorem.sentence,
      gyneco_obstetric_background: FFaker::Lorem.word,
      system_background: FFaker::Lorem.word,
      family_inheritance_background: FFaker::Lorem.word,
      physic_exploration: FFaker::Lorem.word,
      other_background: FFaker::Lorem.word,
      created_at: FFaker::Time.between(10.years.ago, 2.months.ago),
      referred_by: FFaker::NameMX.name,
      hospital_id: doctor.hospital_id
    )

    Address.create(
      street: FFaker::Address.street_name, number: n,
      colony: FFaker::Address.street_name, postal_code: FFaker::AddressMX.postal_code,
      municipality: FFaker::AddressMX.municipality, state: FFaker::AddressMX.state,
      country: FFaker::Address.country, addressable_type: "Patient",
      addressable: patient
    )

    # doctor = Doctor.unscoped.first
    doctor.patients << patient

    puts "Creating #{patient} Appoinments"
    10.times do
      Appoinment.create(
        reason: FFaker::Lorem.phrase, note: FFaker::HTMLIpsum.p,
        prescription: FFaker::Lorem.paragraph, recommendations: FFaker::Lorem.paragraph,
        created_at: FFaker::Time.between(10.years.ago, 2.months.ago),
        doctor: doctor, patient: patient
      )
    end
  end
end

fake_referred_doctors = [
  {full_name: FFaker::NameMX.unique.full_name, specialty: FFaker::Skill.unique.specialty},
  {full_name: FFaker::NameMX.unique.full_name, specialty: FFaker::Skill.unique.specialty}
]
referred_doctors =
  doctors.map { |doctor| doctor.referred_doctors.create!(fake_referred_doctors) }
puts "Referred Doctors #{referred_doctors.size}"
