FactoryBot.define do
  factory :patient do
    name { "Marco" }
    first_name { "Chavez" }
    last_name { "Castro" }
    birthday { "1989-09-19" }
    height { 180.00 }
    weight { 100.00 }
    blood_group { "ARH+" }
    occupation { "Herrero" }
    referred_by { "Pedro Ramos" }
    place_of_birth { "Oaxaca de Juárez" }
    cellphone { "951 123 4567" }
    marital_status { "Soltero" }
    comments { "Algo que decir" }
    sex { "Masculino" }
    role { "patient" }
    type { "Patient" }
    confirmed_at { Time.now }

    after :build do |patient|
      if patient.doctors.nil?
        patient.doctors = build_list :doctor, 1
      end
      patient.clinic_history = build :clinic_history
      patient.address = build :address
    end

    trait :with_avatar do
      after :create do |patient|
        file_path = Rails.root.join("spec", "support", "assets", "avatar.jpg")
        patient.avatar.attach(io: File.open(file_path), filename: "avatar.jpg", content_type: "image/jpg")
      end
    end

  end
end
