# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Address do
  it { should belong_to :addressable }

  it { should validate_presence_of :state }

  it '#to_s' do
    address = build(:address, street: 'Calle', number: '123', colony: 'Colonia', postal_code: '12345',
                              municipality: 'Municipio')
    expect(address.to_s).to eq("Calle 123\nColonia\n12345 Municipio")
  end
end
