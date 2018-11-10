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
    sex { "Masculino" }
    type { "Patient" }
    confirmed_at { Time.now }
    association :doctors, factory: :doctor
  end
end
