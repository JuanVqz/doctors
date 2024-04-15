# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ReferredDoctorsHelper do
  describe '#call_to phone_number' do
    it 'returns a link with the phone number' do
      expect(call_to('555111111')).to include 'href'
      expect(call_to('555111111')).to include 'tel:555111111'
    end

    it "doesn't return a link with the phone number" do
      expect(call_to('')).to be_nil
    end
  end
end
