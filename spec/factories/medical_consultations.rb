FactoryBot.define do
  factory :medical_consultation do
    reason { "MyText" }
    subjetive { "MyText" }
    objetive { "MyText" }
    plan { "MyText" }
    diagnosis { "MyText" }
    treatment { "MyText" }
    observations { "MyText" }
    prescription { "MyText" }
    lab_results { "MyText" }
    histopathology { "MyText" }
    comments { "MyText" }
    doctor { nil }
    patient { nil }
  end
end
