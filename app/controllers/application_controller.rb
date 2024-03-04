class ApplicationController < ActionController::Base
  include Pagy::Backend

  layout :layout_by_resource

  def current_hospital
    @current_hospital ||= Hospital.find_by(subdomain: request.subdomain)
  end
  helper_method :current_hospital

  def after_sign_in_path_for resource
    return patients_path if user_signed_in?
    super
  end

  def generar_pdf name
    {
      pdf: pdf_name,
      page_size: "Letter",
      template: "pdfs/#{name}.pdf.erb",
      viewport_size: "1280x1024",
      header: {
        html: {template: "layouts/pdfs/_header.pdf.erb"},
        spacing: 20
      },
      footer: {html: {template: "layouts/pdfs/_footer.pdf.erb"}},
      layout: "pdfs/hospital"
    }
  end

  private

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
