# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pdf::Prescription do
  describe '#content' do
    let(:appointment) { create(:appointment) }
    let(:pdf) { described_class.new(appointment) }

    it 'returns a PDF' do
      expect(pdf.content).to be_a(String)
    end

    it 'returns PDF options' do
      options = {
        filename: "#{appointment.patient_id}_#{appointment.id}_#{appointment.created_at}.pdf",
        type: 'application/pdf',
        disposition: 'inline'
      }
      expect(pdf.options).to eq options
    end
  end
end
