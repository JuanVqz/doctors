require "ffaker"

Rails.logger.debug "Creating Hospitals"
fake_hospitals = [
  {
    name: "Hospital Pediatrico", subdomain: "demo",
    description: "Salvando Vidas", tags: "Cirugía, Especialistas",
    about: "La fundación del Hospital Infantil de México",
    schedule: "Lunes a Viernes de 09:00 - 19:00"
  }, {
    name: "Hospital Gastroenterologia", subdomain: "uno",
    description: "Salvando Vidas", tags: "Cirugía, Especialistas",
    about: "La fundación del Hospital Infantil de México",
    schedule: "Lunes a Viernes de 09:00 - 19:00"
  }, {
    name: "Hospital Ginecologia", subdomain: "dos",
    description: "Salvando Vidas", tags: "Cirugía, Especialistas",
    about: "La fundación del Hospital Infantil de México",
    schedule: "Lunes a Viernes de 09:00 - 19:00"
  }, {
    name: "Sto Domingo de Guzmán", subdomain: "tres",
    description: "Salvando Vidas", tags: "Cirugía, Especialistas",
    about: "La fundación del Hospital Infantil de México",
    schedule: "Lunes a Viernes de 09:00 - 19:00"
  }
]

hospitals = Hospital.create(fake_hospitals)
Rails.logger.debug { "Hospitals #{hospitals.size}" }

hospitals.each do |hospital|
  Address.create(
    street: "Emiliano Zapata", number: "Int 10", colony: "Reforma",
    municipality: "Oaxaca de Juárez", addressable: hospital
  )
end

Rails.logger.debug "Creating Doctors"
fake_doctors = [
  {
    name: "Pedro", first_name: "Demo", last_name: "Demo",
    specialty: "Cirujano Plastico", email: "cero@gmail.com",
    password: "123456", password_confirmation: "123456", confirmed_at: Time.zone.now,
    hospital_id: Hospital.find_by(subdomain: "demo").id,
    role: "admin"
  }, {
    name: "Rafael", first_name: "Uno", last_name: "Uno",
    specialty: "Cirujano Plastico", email: "uno@gmail.com",
    password: "123456", password_confirmation: "123456", confirmed_at: Time.zone.now,
    hospital_id: Hospital.find_by(subdomain: "uno").id, role: "admin"
  }, {
    name: "Carlos", first_name: "Dos", last_name: "Dos",
    specialty: "Cirujano Plastico", email: "dos@gmail.com",
    password: "123456", password_confirmation: "123456", confirmed_at: Time.zone.now,
    hospital_id: Hospital.find_by(subdomain: "dos").id, role: "admin"
  }, {
    name: "Edgardo", first_name: "Tres", last_name: "Tres",
    specialty: "Cirujano Plastico", email: "tres@gmail.com",
    password: "123456", password_confirmation: "123456", confirmed_at: Time.zone.now,
    hospital_id: Hospital.find_by(subdomain: "tres").id, role: "admin"
  }
]

doctors = Doctor.create(fake_doctors)
Rails.logger.debug { "Doctors #{doctors.size}" }

Rails.logger.debug "Creating Patients"
doctors.each do |doctor|
  Rails.logger.debug "======================================================================="
  Rails.logger.debug { "Doctor: #{doctor.name} ID: #{doctor.id} Hospital: #{doctor.hospital} ID: #{doctor.hospital_id}" }
  10.times do |n|
    Rails.logger.debug { "#{n} - 10" }
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

    Rails.logger.debug { "Creating #{patient} Appoinments" }
    30.times do
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
  {full_name: FFaker::NameMX.unique.full_name, specialty: FFaker::Skill.unique.specialty, phone_number: "1234567890"},
  {full_name: FFaker::NameMX.unique.full_name, specialty: FFaker::Skill.unique.specialty, phone_number: "0987654321"}
]
referred_doctors =
  doctors.map { |doctor| doctor.referred_doctors.create!(fake_referred_doctors) }
Rails.logger.debug { "Referred Doctors #{referred_doctors.size}" }
