# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PatientReferral do
  it { should define_enum_for(:importance) }

  it do
    expect(subject).to define_enum_for(:importance).with_values(%i[electivo urgente])
  end

  describe '#validations' do
    let(:doctor) { build_stubbed(:doctor) }
    let(:patient) { build_stubbed(:patient) }
    let(:referred_doctor) { build_stubbed(:referred_doctor) }
    let(:hospital) { build_stubbed(:hospital) }

    it 'is valid' do
      patient_referral = build(:patient_referral,
                               patient:,
                               doctor:,
                               referred_doctor:,
                               hospital:)

      expect(patient_referral).to be_valid
    end

    it 'is invalid' do
      patient_referral = build(:patient_referral,
                               patient: nil,
                               doctor: nil,
                               referred_doctor: nil,
                               hospital: nil)

      expect(patient_referral).to be_invalid
      expect(patient_referral.errors.count).to eq 7
    end
  end
end
