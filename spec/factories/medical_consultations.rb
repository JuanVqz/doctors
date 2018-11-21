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
