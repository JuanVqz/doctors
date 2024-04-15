FactoryBot.define do
  factory :appointment do
    sequence(:reason) { |n| "Motivo #{n}" }
    note { "MyText" }
    sequence(:prescription) { |n| "Prescription #{n}" }
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
    doctor
    patient
    hospital
  end

  trait :with_files do
    after :create do |appointment|
      cv1_path = Rails.root.join("spec/fixtures/files/cv.pdf")
      cv2_path = Rails.root.join("spec/fixtures/files/cv.pdf")
      appointment.files.attach(io: File.open(cv1_path), filename: "cv.pdf", content_type: "application/pdf")
      appointment.files.attach(io: File.open(cv2_path), filename: "cv.pdf", content_type: "application/pdf")
    end
  end
end
