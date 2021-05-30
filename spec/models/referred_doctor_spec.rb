require "rails_helper"

RSpec.describe ReferredDoctor, type: :model do
  it { should belong_to :doctor }
  it { should have_one(:address).dependent(:destroy) }

  context "validations" do
    let(:doctor) { create :doctor }

    it "with valid attributes" do
      referred = build :referred_doctor, doctor: doctor

      expect(referred).to be_valid
    end

    it "with invalid attributes" do
      referred = build :referred_doctor, full_name: nil, specialty: nil, doctor: nil

      expect(referred).to be_invalid
      expect(referred.errors.count).to eq 3
      expect(referred.errors["doctor"][0]).to eq "no puede estar en blanco"
      expect(referred.errors["full_name"][0]).to eq "no puede estar en blanco"
      expect(referred.errors["specialty"][0]).to eq "no puede estar en blanco"
    end
  end # context validations
end
