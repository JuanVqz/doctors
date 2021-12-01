require "rails_helper"

RSpec.describe ApplicationHelper, type: :helper do
  describe "#is_admin?" do
    context "when role is admin" do
      let(:doctor) { create :doctor, role: "doctor" }
      let(:admin) { create :doctor, role: "admin" }

      it "returns false" do
        allow(controller).to receive(:current_user).and_return(doctor)
        expect(helper.is_admin?).to be_falsey
      end

      it "returns true" do
        allow(controller).to receive(:current_user).and_return(admin)
        expect(helper.is_admin?).to be_truthy
      end
    end
  end
end
