require "rails_helper"

RSpec.describe AppoinmentsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/appoinments").to route_to("appoinments#index")
    end

    it "routes to #new" do
      expect(get: "/appoinments/new").to route_to("appoinments#new")
    end

    it "routes to #show" do
      expect(get: "/appoinments/1").to route_to("appoinments#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/appoinments/1/edit").to route_to("appoinments#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/appoinments").to route_to("appoinments#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/appoinments/1").to route_to("appoinments#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/appoinments/1").to route_to("appoinments#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/appoinments/1").to route_to("appoinments#destroy", id: "1")
    end
  end
end
