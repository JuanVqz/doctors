FactoryBot.define do
  factory :hospital do
    sequence(:name) { |n| "Santa Ursula #{n}" }
    sequence(:subdomain) { |n| "ursula#{n}" }
    description { "Es un hospital seguro" }
    about { "Algo acerca del doctor" }
    schedule { "Lunes a Viernes de 09:00 - 19:00" }
    tags { "Cirugía general gastrointestinal, Clínica de hernias" }
    facebook { nil }
    twitter { nil }
    linkedin { nil }
    maps { nil }
  end

  trait :basic do
    plan { :basic }
  end

  trait :medium do
    plan { :medium }
  end
end
