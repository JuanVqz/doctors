module StimulusHelper
  def resize_field_controller
    {
      data: {
        controller: "resize-field",
        resize_field_target: :element,
        resize_field_min_height_value: 20,
        action: "input->resize-field#update"
      }
    }
  end
end
