module Feature
  module SubdomainHelpers
    def set_capybara_subdomain subdomain
      Capybara.app_host = "http://#{subdomain}.lvh.me"
    end
  end
end
