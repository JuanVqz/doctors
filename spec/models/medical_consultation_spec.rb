require 'rails_helper'

RSpec.describe MedicalConsultation, type: :model do
  it { should belong_to :doctor }
  it { should belong_to :patient }

  it { should validate_presence_of :reason }
  it { should validate_presence_of :prescription }
  it { should validate_presence_of :patient_id }

  describe "#update_patient" do
    let(:patient) { create :patient, height: 160, weight: 60 }
    let(:medical_consultation) do
      create :medical_consultation, patient: patient,
        height: 170, weight: 70
    end

    before { medical_consultation }

    context "when create a medical_consultation" do
      it "update patient height and weight" do
        expect(medical_consultation.patient.height).to eq 170.00
        expect(medical_consultation.patient.weight).to eq 70.00
      end
    end

    context "when update a medical_consultation" do
      it "update patient height and weight" do
        medical_consultation.update(height: 180, weight: 80)
        expect(medical_consultation.patient.height).to eq 180.00
        expect(medical_consultation.patient.weight).to eq 80.00
      end
    end
  end

  describe ".search" do
    let(:mateo) do
      create :patient, name: "Mateo", first_name: "Pérez",
        last_name: "Toledo"
    end

    let(:josue) do
      create :patient, name: "Josue", first_name: "Alvarez",
        last_name: "Suarez"
    end

    let(:medical_consultation_one) do
      create :medical_consultation, reason: "Motivo 1",
        diagnosis: "Diagnostico 1", prescription: "Receta 1",
        patient: mateo
    end

    let(:medical_consultation_two) do
      create :medical_consultation, reason: "Otra cosa",
      diagnosis: "Practica", prescription: "Persona",
      patient: josue
    end

    let(:medical_consultation_three) do
      create :medical_consultation, reason: "Mi razón",
        diagnosis: "Practica", prescription: "Imprimir",
        patient: mateo
    end

    before :each do
      [medical_consultation_one, medical_consultation_two,
      medical_consultation_three]
    end

    context "when search for reason 'RaZón'" do
      it "returns 1" do
        expect(MedicalConsultation.search("RaZón").count).to eq 1
      end
    end

    context "when search for diagnosis 'PracTicA'" do
      it "returns 2" do
        expect(MedicalConsultation.search("PracTicA").count).to eq 2
      end
    end

    context "when search for prescription 'ImpriMir'" do
      it "returns 1" do
        expect(MedicalConsultation.search("ImpriMir").count).to eq 1
      end
    end
  end

  describe "returns medical_consultations" do
    let(:doctor_one) { create :doctor, name: "Pedro" }
    let(:doctor_two) { create :doctor, name: "José" }

    let(:patient_one) do
      create :patient, name: "Ramon", doctors: [doctor_one, doctor_two]
    end
    let(:patient_two) do
      create :patient, name: "Julian", doctors: [doctor_one, doctor_two]
    end

    let(:medical_consultations_doctor_one) do
      create_list :medical_consultation, 5, doctor: doctor_one, patient: patient_one
    end
    let(:medical_consultations_doctor_two) do
      create_list :medical_consultation, 3, doctor: doctor_two, patient: patient_two
    end

    before :each do
      medical_consultations_doctor_one
      medical_consultations_doctor_two
    end

    it ".per_doctor" do
      expect(MedicalConsultation.per_doctor(doctor_one.id).count).to eq 5
    end

    it ".per_patient" do
      expect(MedicalConsultation.per_patient(patient_one.id).count).to eq 5
    end

    it ".by_doctor_and_patient" do
      expect(MedicalConsultation.by_doctor_and_patient(doctor_one.id, patient_one.id).count).to eq 5
    end
  end

end
