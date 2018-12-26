class ApplicationController < ActionController::Base
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  layout :layout_by_resource

  before_action :scope_current_hospital

  def current_hospital
    @current_hospital ||= Hospital.find_by(subdomain: request.subdomain)
  end
  helper_method :current_hospital

  def after_sign_in_path_for resource
    return patients_path if user_signed_in?
    super
  end

  #before_action :ensure_subdomain
  private

  #def ensure_subdomain
    #return "no subdomain" unless current_hospital.present?
  #end

  def scope_current_hospital
    Hospital.current_id = current_hospital ? current_hospital.id : current_user.hospital_id
  end

  def user_not_authorized
    flash[:alert] = "Usuario no autorizado para realizar esta acción!"
    redirect_to(request.referrer || root_path)
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
