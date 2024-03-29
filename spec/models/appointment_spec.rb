require "rails_helper"

RSpec.describe Appointment do
  it { should belong_to :doctor }
  it { should belong_to :patient }
  it { should belong_to :hospital }
  it { should have_many_attached :files }

  it { should validate_presence_of :reason }
  it { should validate_presence_of :prescription }
  it { should validate_presence_of :doctor }
  it { should validate_presence_of :patient }
  it { should validate_presence_of :hospital }
  it { should validate_numericality_of(:heart_rate).is_greater_than_or_equal_to 0 }
  it { should validate_numericality_of(:breathing_rate).is_greater_than_or_equal_to 0 }
  it { should validate_numericality_of(:temperature).is_greater_than_or_equal_to 0 }
  it { should validate_numericality_of(:glycaemia).is_greater_than_or_equal_to 0 }
  it { should validate_numericality_of(:sat_02).is_greater_than_or_equal_to 0 }
  it { should validate_numericality_of(:cost).is_greater_than_or_equal_to 0 }

  describe "#files" do
    it "has many files" do
      appointment = create(:appointment, :with_files)

      expect(appointment).to be_valid
      expect(appointment.files).to be_attached
    end

    it "has not many files" do
      appointment = create(:appointment)

      expect(appointment).to be_valid
      expect(appointment.files).not_to be_attached
    end
  end

  describe "#update_patient" do
    let(:patient) { create(:patient, height: 160, weight: 60) }
    let!(:appointment) do
      create(:appointment, patient: patient, height: 170, weight: 70)
    end

    context "when create an appointment" do
      it "update patient height and weight" do
        expect(appointment.patient.height).to eq 170.00
        expect(appointment.patient.weight).to eq 70.00
      end
    end

    context "when update an appointment" do
      it "update patient height and weight" do
        appointment.update(height: 180, weight: 80)
        expect(appointment.patient.height).to eq 180.00
        expect(appointment.patient.weight).to eq 80.00
      end
    end
  end

  describe ".search" do
    let(:hospital) { create(:hospital) }
    let(:mateo) do
      create(:patient, name: "Mateo", first_name: "Pérez", last_name: "Toledo", hospital: hospital)
    end

    let(:josue) do
      create(:patient, name: "Josue", first_name: "Alvarez", last_name: "Suarez", hospital: hospital)
    end

    let!(:appointment) do
      create(:appointment, reason: "Motivo 1", note: "Diagnostico 1", prescription: "Receta 1", patient: mateo, hospital: hospital)
    end

    let!(:appoinment_two) do
      create(:appointment, reason: "Otra cosa", note: "Practica", prescription: "Persona", patient: josue, hospital: hospital)
    end

    let!(:appoinment_tree) do
      create(:appointment, reason: "Mi razón", note: "Practica", prescription: "Imprimir", patient: mateo, hospital: hospital)
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

  describe "returns appointment" do
    let(:hospital) { create(:hospital) }
    let(:doctor_one) { create(:doctor, name: "Pedro", hospital: hospital) }
    let(:doctor_two) { create(:doctor, name: "José", hospital: hospital) }

    let(:patient_one) do
      create(:patient, name: "Ramon", doctors: [doctor_one, doctor_two], hospital: hospital)
    end
    let(:patient_two) do
      create(:patient, name: "Julian", doctors: [doctor_one, doctor_two], hospital: hospital)
    end

    let!(:appoinment_doctor_one) do
      create_list(:appointment, 5, doctor: doctor_one, patient: patient_one, hospital: hospital)
    end
    let!(:appoinment_doctor_two) do
      create_list(:appointment, 3, doctor: doctor_two, patient: patient_two, hospital: hospital)
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
