# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Pdf::Prescription::Base do
  describe '#content' do
    let(:appointment) { create(:appointment) }
    let(:pdf) { described_class.new(appointment) }

    it 'returns a PDF' do
      expect(pdf.content).to be_a(String)
    end
  end
end
