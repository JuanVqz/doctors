require 'rails_helper'

RSpec.describe PatientHelper, type: :helper do

  describe "#age" do
    context "returns the patient's age" do
      let(:patient) { create :patient, birthday: "1989-09-19" }

      it "return 18" do
        expect(age(patient)).to eq "29 Años"
      end
    end
  end

end
