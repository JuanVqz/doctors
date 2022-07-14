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
    role { "admin" }
    confirmed_at { Time.zone.now }
    association :hospital, factory: :hospital
  end

  trait :patient do
    role { :patient }
  end

  trait :doctor do
    role { :doctor }
  end

  trait :admin do
    role { :admin }
  end
end
