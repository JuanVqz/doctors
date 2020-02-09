require 'rails_helper'

RSpec.describe MedicalConsultationsHelper, type: :helper do
  describe "#temperature" do
    let(:medical_consultation) { create :medical_consultation  }

    it "is 36.5 should return 36.5°C" do
      expect(temperature(medical_consultation)).to eq "36.5°C"
    end

    it "is 40 should return 40°C" do
      medical_consultation.temperature = 40
      expect(temperature(medical_consultation)).to eq "40°C"
    end

    it "is 0 should return 0°C" do
      medical_consultation.temperature = 0
      expect(temperature(medical_consultation)).to eq "0°C"
    end
  end
end
