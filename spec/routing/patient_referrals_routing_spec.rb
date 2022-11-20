require "rails_helper"

RSpec.describe PatientReferralsController do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/patient_referrals").to route_to("patient_referrals#index")
    end

    it "routes to #new" do
      expect(get: "/patient_referrals/new").to route_to("patient_referrals#new")
    end

    it "routes to #show" do
      expect(get: "/patient_referrals/1").to route_to("patient_referrals#show", id: "1")
    end

    it "routes to #edit" do
      expect(get: "/patient_referrals/1/edit").to route_to("patient_referrals#edit", id: "1")
    end

    it "routes to #create" do
      expect(post: "/patient_referrals").to route_to("patient_referrals#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/patient_referrals/1").to route_to("patient_referrals#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/patient_referrals/1").to route_to("patient_referrals#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/patient_referrals/1").to route_to("patient_referrals#destroy", id: "1")
    end
  end
end
