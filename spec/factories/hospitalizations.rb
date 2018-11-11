FactoryBot.define do
  factory :hospitalization do
    starting { "2018-11-10" }
    ending { "2018-11-10" }
    days_of_stay { "9.99" }
    reason_for_hospitalization { "MyText" }
    treatment { "MyText" }
    doctor { nil }
    patient { nil }
  end
end
