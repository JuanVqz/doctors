# frozen_string_literal: true

module Feature
  module SubdomainHelpers
    def capybara_subdomain(subdomain)
      Capybara.app_host = "http://#{subdomain}.lvh.me"
    end

    def create_hospital_plan_medium
      @hospital = create(:hospital, :medium)
      capybara_subdomain(@hospital.subdomain)
    end
  end
end
