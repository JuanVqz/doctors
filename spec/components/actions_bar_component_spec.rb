# frozen_string_literal: true

require "rails_helper"

RSpec.describe ActionsBarComponent, type: :component do
  context "#text" do
    it "render the register button" do
      render_inline(described_class.new(subject: :appoinment))

      expect(page).to have_text("Registrar Consulta")
    end
  end

  context "#search?" do
    it "renders search form" do
      render_inline(described_class.new(subject: :appoinment, search: true))

      expect(page).to have_css(".level-right")
    end

    it "does not render search form" do
      render_inline(described_class.new(subject: :appoinment, search: false))

      expect(page).to have_no_css(".level-right")
    end
  end
end
