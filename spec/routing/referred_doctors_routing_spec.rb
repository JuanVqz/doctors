require "rails_helper"

RSpec.describe ReferredDoctorsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/referred_doctors").to route_to("referred_doctors#index")
    end

    it "routes to #new" do
      expect(get: "/referred_doctors/new").to route_to("referred_doctors#new")
    end

    it "routes to #show" do
      expect(get: "/referred_doctors/1").to route_to("referred_doctors#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/referred_doctors/1/edit").to route_to("referred_doctors#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/referred_doctors").to route_to("referred_doctors#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/referred_doctors/1").to route_to("referred_doctors#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/referred_doctors/1").to route_to("referred_doctors#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/referred_doctors/1").to route_to("referred_doctors#destroy", id: "1")
    end
  end
end
