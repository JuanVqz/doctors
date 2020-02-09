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
    height { 170.5 }
    weight { 80.0 }
    imc { 26.6406 }
    blood_pressure { "110/80" }
    heart_rate { 18 }
    breathing_rate { 90 }
    temperature { 36.5 }
    glycaemia { 234 }
    sat_02 { 456 }
    cost { 0 }
    recommendation { "Recomendaciones" }

    after :build do |medical_consultation|
      if medical_consultation.doctor.nil?
        medical_consultation.doctor = create :doctor
      end
      if medical_consultation.patient.nil?
        medical_consultation.patient = create :patient,
          doctors: [medical_consultation.doctor]
      end
    end
  end
end
