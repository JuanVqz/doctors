module Feature
  module SubdomainHelpers
    def set_capybara_subdomain
      Capybara.app_host = "http://#{@hospital.subdomain}.lvh.me"
    end

    def create_hospital_plan_medium
      @hospital = create :hospital, :medium
      set_capybara_subdomain
    end
  end
end
