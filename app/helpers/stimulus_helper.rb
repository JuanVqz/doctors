# frozen_string_literal: true

module StimulusHelper
  def resize_field_controller
    {
      data: {
        controller: 'resize-field',
        action: 'input->resize-field#update'
      }
    }
  end
end
