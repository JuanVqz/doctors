# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HospitalizationsHelper, type: :helper do
  it '#statuses_for_select' do
    expect(helper.statuses_for_select).to eq(Hospitalization.statuses.keys)
  end
end
