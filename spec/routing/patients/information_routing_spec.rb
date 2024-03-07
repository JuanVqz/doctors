require "rails_helper"

RSpec.describe Patients::InformationController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/patients/1/information").to route_to("patients/information#index", patient_id: "1")
    end
  end
end
