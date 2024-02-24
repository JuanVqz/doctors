require "rails_helper"

RSpec.describe PatientReferralsHelper do
  it "#importances_for_select" do
    expect(helper.importances_for_select).to eq(PatientReferral.importances.keys)
  end
end
