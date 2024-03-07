require "rails_helper"

RSpec.describe ApplicationHelper do
  it "sexos_for_select" do
    expect(helper.sexos_for_select).to eq(["Femenino", "Masculino"])
  end

  it "blood_groups_for_select" do
    groups = ["ARH+", "ORH+", "BRH+", "ABRH+", "ARH-", "ORH-", "BRH-", "ABRH-"]
    expect(helper.blood_groups_for_select).to eq groups
  end

  context "#sidebar_classes" do
    it "when controller_name is equal to action" do
      allow(helper).to receive(:controller_name).and_return(:controller_name)
      expect(helper.sidebar_classes(:controller_name)).to eq "flex p-2 rounded-lg hover:bg-gray-200 dark:hover:bg-gray-700 bg-gray-200 dark:bg-gray-700"
    end

    it "when controller_name is not equal to action" do
      allow(helper).to receive(:controller_name).and_return(:controller_name)
      expect(helper.sidebar_classes(:foo)).to eq "flex p-2 rounded-lg hover:bg-gray-200 dark:hover:bg-gray-700"
    end
  end
end
