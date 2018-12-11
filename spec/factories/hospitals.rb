FactoryBot.define do
  factory :hospital do
    sequence(:name) { |n| "Santa Ursula #{n}" }
    sequence(:subdomain) { |n| "santa#{n}" }
    description { "Es un hospital seguro" }
  end

  trait :basic do
    plan { :basic }
  end

  trait :medium do
    plan { :medium }
  end
end
