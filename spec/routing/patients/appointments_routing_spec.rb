require "rails_helper"

RSpec.describe Patients::AppointmentsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/patients/1/appointments").to route_to("patients/appointments#index", patient_id: "1")
    end
  end
end
