require "rails_helper"

RSpec.describe Patient, type: :model do
  it { should have_one(:clinic_history).dependent(:destroy) }
  it { should have_one(:address).dependent(:destroy) }
  it { should have_and_belong_to_many :doctors }
  it { should have_many :medical_consultations }
  it { should have_many :hospitalizations }
  it { should have_many :bentos }

  it { should accept_nested_attributes_for(:clinic_history).allow_destroy(true) }
  it { should accept_nested_attributes_for(:address).allow_destroy(true) }

  it { should validate_presence_of :name }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :birthday }
  it { should validate_presence_of :height }
  it { should validate_presence_of :weight }

  describe ".search" do
    let(:hospital) { create :hospital }
    let(:doctor) { create :doctor, hospital: hospital }
    let(:jose) do
      create :patient, doctors: [doctor],
        name: "José", first_name: "Pérez", last_name: "Castro"
    end
    let(:juan) do
      create :patient, doctors: [doctor],
        name: "Juan", first_name: "Sanchez", last_name: "Ramos"
    end
    let(:juanito) do
      create :patient, doctors: [doctor],
        name: "Juanito", first_name: "Vasquez", last_name: "Suarez"
    end
    let(:josue) do
      create :patient, doctors: [doctor],
        name: "Josué", first_name: "Garcia", last_name: "Rios"
    end

    context "when search for name 'jUaN'" do
      it "returns nothing" do
        [jose, josue]
        expect(Patient.search("jUaN").count).to eq 0
      end

      it "returns 2" do
        [jose, juan, juanito, josue]
        expect(Patient.search("jUaN").count).to eq 2
      end
    end

    context "when search for first_name 'PéRez'" do
      it "returns nothing" do
        [juan, juanito, josue]
        expect(Patient.search("PéRez").count).to eq 0
      end

      it "returns 1" do
        [jose, juan, juanito, josue]
        expect(Patient.search("PéRez").count).to eq 1
      end
    end

    context "when search for last_name 'RioS'" do
      it "returns nothing" do
        [jose, juan, juanito]
        expect(Patient.search("RioS").count).to eq 0
      end

      it "returns 1" do
        [jose, juan, juanito, josue]
        expect(Patient.search("RioS").count).to eq 1
      end
    end

    context "when search for full_name 'Josué Garcia Rios'" do
      it "returns nothing" do
        [jose, juan, juanito]
        expect(Patient.search("JoSué GarCia RiOs").count).to eq 0
      end

      it "returns 1" do
        [jose, juan, juanito, josue]
        expect(Patient.search("JoSué GarCia RiOs").count).to eq 1
      end
    end
  end
end
