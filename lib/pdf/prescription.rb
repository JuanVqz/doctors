# frozen_string_literal: true

require 'prawn'
require 'prawn/markup'

module Pdf
  class Prescription
    attr_reader :appointment

    def initialize(appointment)
      @appointment = appointment
      @hospital = appointment.hospital
    end

    def content
      doc.font_size 11
      doc.bounding_box([0, 720], width: 500, height: 50) do
        doc.text patient_name, bold: true, align: :right
        doc.text info, align: :right
        doc.text date, align: :right
      end

      doc.bounding_box([0, 660], width: 500, height: 680) do
        doc.markup prescription
        doc.markup recommendations
      end

      doc.render
    end

    def options
      { filename:, type:, disposition: }
    end

    private

    def filename
      "#{appointment.patient_id}_#{appointment.id}_#{appointment.created_at}.pdf"
    end

    def type
      'application/pdf'
    end

    def disposition
      'inline'
    end

    def patient_name
      appointment.patient.to_s
    end

    def info
      "#{age} #{height} #{weight} #{imc}"
    end

    def date
      ApplicationController.helpers.l(appointment.created_at, format: :normal)
    end

    def prescription
      ApplicationController.helpers.raw(appointment.prescription)
    end

    def recommendations
      recommendations = ApplicationController.helpers.raw(appointment.recommendations)
      return if recommendations.blank?

      <<-HTML
        <br/>
        <p><strong>RECOMENDACIONES</strong></p>
        #{recommendations}
      HTML
    end

    def age
      ApplicationController.helpers.age_months(appointment.patient)
    end

    def height
      ApplicationController.helpers.height_for_human(appointment)
    end

    def weight
      ApplicationController.helpers.weight_for_human(appointment)
    end

    def imc
      ApplicationController.helpers.imc_for_human(appointment)
    end

    def doc
      @doc ||= Prawn::Document.new(margin: 30)
    end
  end
end
