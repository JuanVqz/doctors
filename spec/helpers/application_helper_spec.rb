require "rails_helper"

RSpec.describe ApplicationHelper do
  it "sexos_for_select" do
    expect(helper.sexos_for_select).to eq(["Femenino", "Masculino"])
  end

  it "blood_groups_for_select" do
    groups = ["ARH+", "ORH+", "BRH+", "ABRH+", "ARH-", "ORH-", "BRH-", "ABRH-"]
    expect(helper.blood_groups_for_select).to eq groups
  end
end
