module Feature
  module SubdomainHelpers
    def set_capybara_subdomain
      Capybara.app_host = "http://#{@hospital.subdomain}.lvh.me"
    end

    def create_subdomain_hospital
      @hospital = create :hospital, subdomain: "ursula"
      set_capybara_subdomain
    end
  end
end
