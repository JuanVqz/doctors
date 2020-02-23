require "rails_helper"

RSpec.describe HospitalizationsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/hospitalizations").to route_to("hospitalizations#index")
    end

    it "routes to #new" do
      expect(get: "/hospitalizations/new").to route_to("hospitalizations#new")
    end

    it "routes to #show" do
      expect(get: "/hospitalizations/1").to route_to("hospitalizations#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/hospitalizations/1/edit").to route_to("hospitalizations#edit", id: "1")
    end


    it "routes to #create" do
      expect(post: "/hospitalizations").to route_to("hospitalizations#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/hospitalizations/1").to route_to("hospitalizations#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/hospitalizations/1").to route_to("hospitalizations#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/hospitalizations/1").to route_to("hospitalizations#destroy", id: "1")
    end
  end
end
