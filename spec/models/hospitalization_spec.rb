# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Hospitalization do
  it { should define_enum_for :status }

  it do
    expect(subject).to define_enum_for(:status)
      .with_values(['Alta médica', 'Alta voluntaria', 'Traslado a otra unidad'])
  end

  it { should belong_to :hospital }
  it { should belong_to :doctor }
  it { should belong_to :patient }
  it { should belong_to :referred_doctor }

  it { should validate_presence_of :days_of_stay }
  it { should validate_presence_of :hospital }
  it { should validate_presence_of :doctor }
  it { should validate_presence_of :ending }
  it { should validate_presence_of :patient }
  it { should validate_presence_of :starting }
  it { should validate_presence_of :status }
  it { should validate_numericality_of(:days_of_stay).is_greater_than(0) }

  describe '.search' do
    let(:mateo) do
      create(:patient, name: 'Mateo', first_name: 'Pérez',
                       last_name: 'Toledo')
    end

    let(:josue) do
      create(:patient, name: 'Josue', first_name: 'Alvarez',
                       last_name: 'Suarez')
    end

    let(:hospitalization_one) do
      create(:hospitalization, reason_for_hospitalization: 'Motivo 1',
                               treatment: 'Diagnostico 1', days_of_stay: 3.0, patient: mateo)
    end

    let(:hospitalization_two) do
      create(:hospitalization, reason_for_hospitalization: 'Otra cosa',
                               treatment: 'Tratamiento', days_of_stay: 5.0, patient: josue)
    end

    let(:hospitalization_three) do
      create(:hospitalization, reason_for_hospitalization: 'Mi razón',
                               treatment: 'Tratamiento 2', days_of_stay: 10.0, patient: mateo)
    end

    before do
      [hospitalization_one, hospitalization_two, hospitalization_three]
    end

    context "when search for reason_for_hospitalization 'RaZón'" do
      it 'returns 1' do
        expect(described_class.search('RaZón').count).to eq 1
      end
    end

    context "when search for treatment 'TraTamIentO'" do
      it 'returns 2' do
        expect(described_class.search('TraTamIentO').count).to eq 2
      end
    end
  end
end
