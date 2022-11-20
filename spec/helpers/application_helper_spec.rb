require "rails_helper"

RSpec.describe ApplicationHelper do
  describe "#is_admin?" do
    context "when role is admin" do
      let(:doctor) { create(:doctor, role: "doctor") }
      let(:admin) { create(:doctor, role: "admin") }

      it "returns false" do
        allow(controller).to receive(:current_user).and_return(doctor)
        expect(helper).not_to be_is_admin
      end

      it "returns true" do
        allow(controller).to receive(:current_user).and_return(admin)
        expect(helper).to be_is_admin
      end
    end
  end
end
