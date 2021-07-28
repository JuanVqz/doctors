require "rails_helper"

RSpec.describe PatientHelper, type: :helper do

  describe "#age" do
    context "when birthday's patient is present" do
      let(:patient) { create :patient, birthday: "1989-09-19" }

      it "returns 30" do
        allow(Date).to receive(:current).and_return Date.new(2020, 1, 26)
        expect(age(patient)).to eq "30 Años"
      end
    end # context when birthday's patient is present

    context "when birthday's patient isn't present" do
      let(:patient) { build_stubbed :patient, birthday: nil }

      it "returns nil" do
        expect(age(patient)).to be_nil
      end
    end # context when birthday's patient isn't present
  end

  describe "#age_months" do
    context "when birthday's patient is present" do
      let(:patient) { create :patient, birthday: "1995-06-29" }

      it "returns 25 Años 2 meses" do
        allow(Date).to receive(:current).and_return Date.new(2020, 8, 29)
        expect(age_months(patient)).to eq "25 años 2 meses"
      end
    end # context when birthday's patient is present

    context "when birthday's patient is not present" do
      let(:patient) { build_stubbed :patient, birthday: nil }

      it "returns nil" do
        expect(age_months(patient)).to be_nil
      end
    end # context when birthday's patient is not present
  end # describe #age_months
end
