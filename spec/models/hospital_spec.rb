require "rails_helper"

RSpec.describe Hospital do
  it { should have_many(:doctors).dependent(:destroy) }
  it { should have_many(:patient_referrals).dependent(:destroy) }
  it { should have_many(:patients).dependent(:destroy) }
  it { should have_one(:address).dependent(:destroy) }

  it { should accept_nested_attributes_for(:address).allow_destroy(true) }

  it { should validate_presence_of :name }
  it { should validate_uniqueness_of :name }
  it { should validate_presence_of :subdomain }
  it { should validate_uniqueness_of :subdomain }

  describe "plan" do
    context "when plan is 'basic'" do
      let(:hospital) { create(:hospital, plan: :basic) }

      it "returns true" do
        expect(hospital).to be_basic
      end

      it "returns false" do
        expect(hospital).not_to be_medium
      end
    end

    context "when plan is 'medium'" do
      let(:hospital) { create(:hospital, plan: :medium) }

      it "returns true" do
        expect(hospital).to be_medium
      end

      it "returns false" do
        expect(hospital).not_to be_basic
      end
    end
  end
end
