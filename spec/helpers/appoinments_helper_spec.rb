require "rails_helper"

RSpec.describe AppoinmentsHelper do
  describe "#temperature" do
    let(:appoinment) { build(:appoinment) }

    it "is 36.5 should return 36.5°C" do
      expect(temperature(appoinment)).to eq "36.5°C"
    end

    it "is 40 should return 40°C" do
      appoinment.temperature = 40
      expect(temperature(appoinment)).to eq "40°C"
    end

    it "is 0 should return 0°C" do
      appoinment.temperature = 0
      expect(temperature(appoinment)).to eq "0°C"
    end
  end
end
