require "rails_helper"

RSpec.describe HospitalsHelper do
  describe "#tags_spliter" do
    context "when tags is 'uno, dos'" do
      let(:hospital) { create(:hospital, :basic, tags: "uno,dos") }

      it "returns ['uno','dos']" do
        expect(tags_spliter(hospital)).to eq ["uno", "dos"]
      end
    end

    context "when tags is ''" do
      let(:hospital) { create(:hospital, :basic, tags: "") }

      it "returns []" do
        expect(tags_spliter(hospital)).to eq []
      end
    end
  end
end
