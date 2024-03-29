FactoryBot.define do
  factory :referred_doctor do
    sequence(:full_name) { |n| "Referred Doctor #{n}" }
    sequence(:specialty) { |n| "Specialty #{n}" }
    phone_number { "5551111111" }
    doctor
  end
end
