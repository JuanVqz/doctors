require "rails_helper"

RSpec.describe AppointmentsHelper do
  describe "#temperature" do
    let(:appointment) { build(:appointment) }

    it "is 36.5 should return 36.5°C" do
      expect(temperature(appointment)).to eq "36.5°C"
    end

    it "is 40 should return 40°C" do
      appointment.temperature = 40
      expect(temperature(appointment)).to eq "40°C"
    end

    it "is 0 should return 0°C" do
      appointment.temperature = 0
      expect(temperature(appointment)).to eq "0°C"
    end
  end
end
