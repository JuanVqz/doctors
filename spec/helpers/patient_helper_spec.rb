require 'rails_helper'

RSpec.describe PatientHelper, type: :helper do

  describe "#age" do
    context "returns the patient's age" do
      let(:patient) { create :patient, birthday: "1989-09-19" }

      it "returns 30" do
        allow(Date).to receive(:current).and_return Date.new(2020, 1, 26)
        expect(age(patient)).to eq "30 Años"
      end
    end
  end

end
