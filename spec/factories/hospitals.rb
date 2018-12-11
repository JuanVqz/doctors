FactoryBot.define do
  factory :hospital do
    sequence(:name) { |n| "Santa Ursula #{n}" }
    sequence(:subdomain) { |n| "santa#{n}" }
    description { "Es un hospital seguro" }
    plan { nil }
  end
end
