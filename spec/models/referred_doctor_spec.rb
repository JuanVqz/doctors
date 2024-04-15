# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReferredDoctor do
  it { should belong_to :doctor }
  it { should belong_to :hospital }
  it { should have_one(:address).dependent(:destroy) }
  it { should have_many :hospitalizations }

  context 'validations' do
    let(:doctor) { build_stubbed(:doctor) }
    let(:hospital) { build_stubbed(:hospital) }

    it 'with valid attributes' do
      referred = build(:referred_doctor, doctor:, hospital:)

      expect(referred).to be_valid
    end

    it 'with invalid attributes' do
      referred = build(:referred_doctor, full_name: nil, specialty: nil, doctor: nil)

      expect(referred).to be_invalid
      expect(referred.errors.count).to eq 3
    end

    context '#phone_number' do
      it "doesn't accept non number digits" do
        referred = build(:referred_doctor, phone_number: '555-111-1111')

        expect(referred).to be_invalid
        expect(referred.errors['phone_number'][0]).to eq 'acepta solo números'
      end

      it 'accepts just 10 digits' do
        referred = build(:referred_doctor, phone_number: '123')

        expect(referred).to be_invalid
        expect(referred.errors['phone_number'][0]).to eq 'longitud errónea (debe ser de 10 caracteres)'
      end

      it 'allows phone number is blank' do
        referred = build(:referred_doctor, phone_number: '')

        expect(referred).to be_valid
      end
    end
  end

  describe '.search' do
    let(:doctor) { create(:doctor) }
    let(:edgardo) do
      create(:referred_doctor,
             full_name: 'Edgardo Gonzalez',
             specialty: 'Dentista',
             phone_number: 9_999_999_999,
             doctor:)
    end
    let(:david) do
      create(:referred_doctor,
             full_name: 'David Zepeda',
             specialty: 'General',
             phone_number: 5_555_555_555,
             doctor:)
    end

    context 'search by full_name' do
      it 'returns one referred doctor' do
        edgardo
        david

        expect(ReferredDoctor.search(edgardo.full_name).count).to eq 1
      end

      it 'returns zero' do
        expect(ReferredDoctor.search('Foo').count).to be_zero
      end
    end

    context 'search by specialty' do
      it 'returns one referred doctor' do
        edgardo
        david

        expect(ReferredDoctor.search(david.specialty).count).to eq 1
      end

      it 'returns zero' do
        expect(ReferredDoctor.search('Foo').count).to be_zero
      end
    end

    context 'search by phone_number' do
      it 'returns one referred doctor' do
        edgardo
        david

        expect(ReferredDoctor.search(edgardo.phone_number).count).to eq 1
      end

      it 'returns zero' do
        expect(ReferredDoctor.search(333_333_333).count).to be_zero
      end
    end
  end
end
