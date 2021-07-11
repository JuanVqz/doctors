FactoryBot.define do
  factory :patient_referral do
    subject { "MyString" }
    content { "MyText" }
    importance { 0 }
    association :patient, factory: :patient
    association :doctor, factory: :doctor
    association :referred_doctor, factory: :referred_doctor
    association :hospital, factory: :hospital
  end
end
