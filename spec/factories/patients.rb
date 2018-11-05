FactoryBot.define do
  factory :patient do
    name { "Marco" }
    first_name { "Chavez" }
    last_name { "Castro" }
    birthday { "1989-09-19" }
    height { 180.00 }
    weight { 100.00 }
    blood_group { "A+" }
    occupation { "Herrero" }
    referred_by { "Pedro Ramos" }
    type { "Patient" }
    confirmed_at { Time.now }
    association :doctor, factory: :doctor
  end
end
