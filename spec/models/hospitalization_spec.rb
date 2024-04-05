require "rails_helper"

RSpec.describe Hospitalization do
  it { should define_enum_for :status }

  it do
    expect(subject).to define_enum_for(:status)
      .with_values(["Alta médica", "Alta voluntaria", "Traslado a otra unidad"])
  end

  it { should belong_to :doctor }
  it { should belong_to :patient }
  it { should belong_to(:referred_doctor).optional }

  it { should validate_presence_of :days_of_stay }
  it { should validate_presence_of :doctor }
  it { should validate_presence_of :ending }
  it { should validate_presence_of :patient }
  it { should validate_presence_of :starting }
  it { should validate_presence_of :status }
  it { should validate_numericality_of(:days_of_stay).is_greater_than(0) }

  describe "returns hospitalizations" do
    let(:doctor_one) { create(:doctor, name: "Pedro") }
    let(:doctor_two) { create(:doctor, name: "José") }

    let(:patient_one) do
      create(:patient, name: "Ramon", doctors: [doctor_one, doctor_two])
    end
    let(:patient_two) do
      create(:patient, name: "Julian", doctors: [doctor_one, doctor_two])
    end

    let(:hospitalizations_one) do
      create_list(:hospitalization, 5, doctor: doctor_one, patient: patient_one)
    end
    let(:hospitalization_two) do
      create_list(:hospitalization, 3, doctor: doctor_two, patient: patient_two)
    end

    before do
      hospitalizations_one
      hospitalization_two
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

  describe ".search" do
    let(:mateo) do
      create(:patient, name: "Mateo", first_name: "Pérez",
        last_name: "Toledo")
    end

    let(:josue) do
      create(:patient, name: "Josue", first_name: "Alvarez",
        last_name: "Suarez")
    end

    let(:hospitalization_one) do
      create(:hospitalization, reason_for_hospitalization: "Motivo 1",
        treatment: "Diagnostico 1", days_of_stay: 3.0, patient: mateo)
    end

    let(:hospitalization_two) do
      create(:hospitalization, reason_for_hospitalization: "Otra cosa",
        treatment: "Tratamiento", days_of_stay: 5.0, patient: josue)
    end

    let(:hospitalization_three) do
      create(:hospitalization, reason_for_hospitalization: "Mi razón",
        treatment: "Tratamiento 2", days_of_stay: 10.0, patient: mateo)
    end

    before do
      [hospitalization_one, hospitalization_two, hospitalization_three]
    end

    context "when search for reason_for_hospitalization 'RaZón'" do
      it "returns 1" do
        expect(described_class.search("RaZón").count).to eq 1
      end
    end

    context "when search for treatment 'TraTamIentO'" do
      it "returns 2" do
        expect(described_class.search("TraTamIentO").count).to eq 2
      end
    end
  end
end
