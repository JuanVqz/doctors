require "rails_helper"

RSpec.describe Patient do
  it { should have_one(:address).dependent(:destroy) }
  it { should have_and_belong_to_many :doctors }
  it { should have_many(:appoinments).dependent(:destroy) }
  it { should have_many(:hospitalizations).dependent(:destroy) }
  it { should have_many(:bentos).dependent(:destroy) }

  it { should accept_nested_attributes_for(:address).allow_destroy(true) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :birthday }

  describe "#avatar" do
    it "has an avatar" do
      patient = create(:patient, :with_avatar)

      expect(patient).to be_valid
      expect(patient.avatar).to be_attached
    end

    it "has not an avatar" do
      patient = create(:patient)

      expect(patient).to be_valid
      expect(patient.avatar).not_to be_attached
    end
  end

  describe ".search" do
    let(:hospital) { create(:hospital) }
    let(:doctor) { create(:doctor, hospital: hospital) }
    let(:jose) do
      create(:patient, doctors: [doctor],
        name: "José", first_name: "Pérez", last_name: "Castro")
    end
    let(:juan) do
      create(:patient, doctors: [doctor],
        name: "Juan", first_name: "Sanchez", last_name: "Ramos")
    end
    let(:juanito) do
      create(:patient, doctors: [doctor],
        name: "Juanito", first_name: "Vasquez", last_name: "Suarez")
    end
    let(:josue) do
      create(:patient, doctors: [doctor],
        name: "Josué", first_name: "Garcia", last_name: "Rios")
    end

    context "when search for name 'jUaN'" do
      it "returns nothing" do
        [jose, josue]
        expect(described_class.search("jUaN").count).to eq 0
      end

      it "returns 2" do
        [jose, juan, juanito, josue]
        expect(described_class.search("jUaN").count).to eq 2
      end
    end

    context "when search for first_name 'PéRez'" do
      it "returns nothing" do
        [juan, juanito, josue]
        expect(described_class.search("PéRez").count).to eq 0
      end

      it "returns 1" do
        [jose, juan, juanito, josue]
        expect(described_class.search("PéRez").count).to eq 1
      end
    end

    context "when search for last_name 'RioS'" do
      it "returns nothing" do
        [jose, juan, juanito]
        expect(described_class.search("RioS").count).to eq 0
      end

      it "returns 1" do
        [jose, juan, juanito, josue]
        expect(described_class.search("RioS").count).to eq 1
      end
    end

    context "when search for full_name 'Josué Garcia Rios'" do
      it "returns nothing" do
        [jose, juan, juanito]
        expect(described_class.search("JoSué GarCia RiOs").count).to eq 0
      end

      it "returns 1" do
        [jose, juan, juanito, josue]
        expect(described_class.search("JoSué GarCia RiOs").count).to eq 1
      end
    end

    context "with accent" do
      it "returns 2 items" do
        create(:patient, doctors: [doctor], name: "Aron")
        create(:patient, doctors: [doctor], name: "Áron")

        expect(described_class.search("Aron").count).to eq 2
      end
    end
  end
end
