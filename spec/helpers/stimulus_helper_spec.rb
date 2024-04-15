# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StimulusHelper, type: :helper do
  describe '#resize_field_controller' do
    it 'returns the correct data attributes' do
      expected = {
        data: {
          controller: 'resize-field',
          action: 'input->resize-field#update'
        }
      }
      expect(helper.resize_field_controller).to eq(expected)
    end
  end
end
