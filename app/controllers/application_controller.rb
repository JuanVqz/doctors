class ApplicationController < ActionController::Base
  layout :layout_by_resource

  before_action :scope_current_hospital

  def current_hospital
    @current_hospital ||= Hospital.find_by(subdomain: request.subdomain)
  end
  helper_method :current_hospital

  before_action :ensure_subdomain
  private

  def ensure_subdomain
    return "no subdomain" unless current_hospital.present?
  end

  def scope_current_hospital
    Hospital.current_id = current_hospital ? current_hospital.id : nil
  end

  def layout_by_resource
    if devise_controller?
      "devise"
    elsif main_controller?
      "main"
    else
      "application"
    end
  end

  def main_controller?
    is_a?(MainController)
  end
end
