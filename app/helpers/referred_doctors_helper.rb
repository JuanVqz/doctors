module ReferredDoctorsHelper
  def call_to phone_number
    return if phone_number.blank?

    link_to "Llamar al #{phone_number}", "tel:#{phone_number}"
  end
end
