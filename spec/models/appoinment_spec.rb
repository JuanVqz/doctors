require "rails_helper"

RSpec.describe Appoinment do
  it { should belong_to :doctor }
  it { should belong_to :patient }
  it { should have_many_attached :files }

  it { should validate_presence_of :reason }
  it { should validate_presence_of :prescription }
  it { should validate_numericality_of(:heart_rate).is_greater_than_or_equal_to 0 }
  it { should validate_numericality_of(:breathing_rate).is_greater_than_or_equal_to 0 }
  it { should validate_numericality_of(:temperature).is_greater_than_or_equal_to 0 }
  it { should validate_numericality_of(:glycaemia).is_greater_than_or_equal_to 0 }
  it { should validate_numericality_of(:sat_02).is_greater_than_or_equal_to 0 }
  it { should validate_numericality_of(:cost).is_greater_than_or_equal_to 0 }

  describe "#files" do
    it "has many files" do
      appoinment = create(:appoinment, :with_files)

      expect(appoinment).to be_valid
      expect(appoinment.files).to be_attached
    end

    it "has not many files" do
      appoinment = create(:appoinment)

      expect(appoinment).to be_valid
      expect(appoinment.files).not_to be_attached
    end
  end # describe #file

  describe "#update_patient" do
    let(:patient) { create(:patient, height: 160, weight: 60) }
    let!(:appoinment) do
      create(:appoinment, patient: patient, height: 170, weight: 70)
    end

    context "when create an appoinment" do
      it "update patient height and weight" do
        expect(appoinment.patient.height).to eq 170.00
        expect(appoinment.patient.weight).to eq 70.00
      end
    end

    context "when update an appoinment" do
      it "update patient height and weight" do
        appoinment.update(height: 180, weight: 80)
        expect(appoinment.patient.height).to eq 180.00
        expect(appoinment.patient.weight).to eq 80.00
      end
    end
  end

  describe ".search" do
    let(:mateo) do
      create(:patient, name: "Mateo", first_name: "Pérez", last_name: "Toledo")
    end

    let(:josue) do
      create(:patient, name: "Josue", first_name: "Alvarez", last_name: "Suarez")
    end

    let!(:appoinment) do
      create(:appoinment, reason: "Motivo 1", note: "Diagnostico 1",
        prescription: "Receta 1", patient: mateo)
    end

    let!(:appoinment_two) do
      create(:appoinment, reason: "Otra cosa", note: "Practica",
        prescription: "Persona", patient: josue)
    end

    let!(:appoinment_tree) do
      create(:appoinment, reason: "Mi razón", note: "Practica",
        prescription: "Imprimir", patient: mateo)
    end

    context "search by reason, note or prescription" do
      it "returns one matches" do
        expect(described_class.search("RaZón").count).to eq 1
      end

      it "returns two matches" do
        expect(described_class.search("PracTicA").count).to eq 2
      end

      it "returns one matches" do
        expect(described_class.search("ImpriMir").count).to eq 1
      end
    end
  end

  describe "returns appoinment" do
    let(:doctor_one) { create(:doctor, name: "Pedro") }
    let(:doctor_two) { create(:doctor, name: "José") }

    let(:patient_one) do
      create(:patient, name: "Ramon", doctors: [doctor_one, doctor_two])
    end
    let(:patient_two) do
      create(:patient, name: "Julian", doctors: [doctor_one, doctor_two])
    end

    let!(:appoinment_doctor_one) do
      create_list(:appoinment, 5, doctor: doctor_one, patient: patient_one)
    end
    let!(:appoinment_doctor_two) do
      create_list(:appoinment, 3, doctor: doctor_two, patient: patient_two)
    end

    it ".per_doctor" do
      expect(described_class.per_doctor(doctor_one.id).count).to eq 5
    end

    it ".per_patient" do
      expect(described_class.per_patient(patient_one.id).count).to eq 5
    end

    it ".by_doctor_and_patient" do
      expect(described_class.by_doctor_and_patient(doctor_one.id, patient_one.id).count).to eq 5
    end
  end
end
