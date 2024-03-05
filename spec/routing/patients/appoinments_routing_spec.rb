require "rails_helper"

RSpec.describe Patients::AppoinmentsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/patients/1/appoinments").to route_to("patients/appoinments#index", patient_id: "1")
    end
  end
end
