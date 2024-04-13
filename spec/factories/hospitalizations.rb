FactoryBot.define do
  factory :hospitalization do
    starting { "2018-11-11" }
    ending { "2018-11-16" }
    days_of_stay { "5" }
    reason_for_hospitalization { "MyText" }
    treatment { "MyText" }
    input_diagnosis { "MyText" }
    output_diagnosis { "MyText" }
    recommendations { "MyText" }
    status { "Alta voluntaria" }
    doctor
    patient
    hospital
    referred_doctor
  end
end
