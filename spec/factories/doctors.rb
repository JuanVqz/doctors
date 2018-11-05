FactoryBot.define do
  factory :doctor do
    name { "Pedro" }
    first_name { "Pérez" }
    last_name { "Ramos" }
    specialty { "Medico General" }
    professional_card { nil }
    sequence(:email) { |n| "doctor#{n}@gmail.com" }
    password { "123456" }
    type { "Doctor" }
    confirmed_at { Time.now }
    association :hospital, factory: :hospital
  end
end
