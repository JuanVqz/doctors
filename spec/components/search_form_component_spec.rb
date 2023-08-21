# frozen_string_literal: true

require "rails_helper"

RSpec.describe SearchFormComponent, type: :component do
  it "render the search form" do
    render_inline(described_class.new(search_path: "/patients", placeholder: "Pacientes"))

    expect(page).to have_xpath("//form[@action='/patients']")
    expect(page).to have_field("query", placeholder: "Buscar Pacientes")
    expect(page).to have_button("Buscar")
  end
end
