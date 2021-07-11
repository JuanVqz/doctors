require "rails_helper"

RSpec.describe PatientReferral, type: :model do
  it { should define_enum_for(:importance) }

  it do
    should define_enum_for(:importance).with_values([:electivo, :urgente])
  end

  describe "#validations" do
    let(:doctor) { build_stubbed :doctor }
    let(:referred_doctor) { build_stubbed :referred_doctor }
    let(:hospital) { build_stubbed :hospital }

    it "is valid" do
      patient_referral = build :patient_referral, doctor:doctor,
        referred_doctor: referred_doctor, hospital: hospital

      expect(patient_referral).to be_valid
    end

    it "is invalid" do
      patient_referral = build :patient_referral, patient: nil, doctor: nil,
        referred_doctor: nil, hospital: nil

      expect(patient_referral).to be_invalid
      expect(patient_referral.errors.count).to eq 4
      expect(patient_referral.errors["patient"][0]).to eq "no puede estar en blanco"
      expect(patient_referral.errors["doctor"][0]).to eq "no puede estar en blanco"
      expect(patient_referral.errors["referred_doctor"][0]).to eq "no puede estar en blanco"
      expect(patient_referral.errors["hospital"][0]).to eq "no puede estar en blanco"
    end
  end # describe #validations
end
