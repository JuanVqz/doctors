FactoryBot.define do
  factory :appoinment do
    reason { "MyString" }
    note { "MyText" }
    prescription { "MyText" }
    recommendations { "MyText" }
    imc { 1.5 }
    weight { 1.5 }
    height { 1.5 }
    blood_pressure { "110/80" }
    heart_rate { 18 }
    breathing_rate { 90 }
    temperature { 36.5 }
    glycaemia { 234 }
    sat_02 { 456 }
    cost { 1.5 }
    cabinet_results { "MyText" }
    histopathology { "MyText" }

    after :build do |appoinment|
      appoinment.doctor = create :doctor if appoinment.doctor.nil?
      if appoinment.patient.nil?
        appoinment.patient = create :patient, doctors: [appoinment.doctor]
      end
    end
  end
end