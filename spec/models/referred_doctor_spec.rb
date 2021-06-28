require "rails_helper"

RSpec.describe ReferredDoctor, type: :model do
  it { should belong_to :doctor }
  it { should have_one(:address).dependent(:destroy) }
  it { should have_many :hospitalizations }

  describe "#by_doctor" do
    let(:doctor) { create :doctor }
    let(:another_doctor) { create :doctor, name: "Ramon" }
    let(:referred_doctors) do
      create_list :referred_doctor, 2, doctor: doctor
    end
    let(:another_referred_doctors) do
      create_list :referred_doctor, 2, doctor: another_doctor
    end

    it "returns two referred doctor" do
      referred_doctors
      another_referred_doctors

      expect(ReferredDoctor.by_doctor(doctor.id).count).to eq 2
    end
  end # describe #by_doctor

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
