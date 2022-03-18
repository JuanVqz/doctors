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
    let(:doctor) { build_stubbed :doctor }

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

    context "#phone_number" do
      it "doesn't accept non number digits" do
        referred = build :referred_doctor, phone_number: "555-111-1111"

        expect(referred).to be_invalid
        expect(referred.errors["phone_number"][0]).to eq "acepta solo numeros"
      end

      it "accepts just 10 digits" do
        referred = build :referred_doctor, phone_number: "123"

        expect(referred).to be_invalid
        expect(referred.errors["phone_number"][0]).to eq "longitud errónea (debe ser de 10 caracteres)"
      end

      it "allows phone number is blank" do
        referred = build :referred_doctor, phone_number: ""

        expect(referred).to be_valid
      end
    end # context #phone_number
  end # context validations

  describe ".search" do
    let(:doctor) { create :doctor}
    let(:edgardo) do
      create :referred_doctor,
        full_name: "Edgardo Gonzalez",
        specialty: "Dentista",
        phone_number: 9999999999,
        doctor: doctor
    end
    let(:david) do
      create :referred_doctor,
        full_name: "David Zepeda",
        specialty: "General",
        phone_number: 5555555555,
        doctor: doctor
    end

    context "search by full_name" do
      it "returns one referred doctor" do
        edgardo
        david

        expect(ReferredDoctor.search(edgardo.full_name).count).to eq 1
      end

      it "returns zero" do
        expect(ReferredDoctor.search("Foo").count).to be_zero
      end
    end # context search by full_name

    context "search by specialty" do
      it "returns one referred doctor" do
        edgardo
        david

        expect(ReferredDoctor.search(david.specialty).count).to eq 1
      end

      it "returns zero" do
        expect(ReferredDoctor.search("Foo").count).to be_zero
      end
    end # context search by specialty

    context "search by phone_number" do
      it "returns one referred doctor" do
        edgardo
        david

        expect(ReferredDoctor.search(edgardo.phone_number).count).to eq 1
      end

      it "returns zero" do
        expect(ReferredDoctor.search(333333333).count).to be_zero
      end
    end # context search by phone_number
  end # describe .search
end
