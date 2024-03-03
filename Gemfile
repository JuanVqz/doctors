source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.0.3"

gem "bootsnap", require: false
gem "devise"
gem "haml-rails"
gem "pagy"
gem "pg"
gem "puma"
gem "rails", "~> 7.1"
gem "sentry-rails"
gem "sentry-ruby"
gem "simple_form"
gem "stimulus-rails"
gem "trix-rails", require: "trix"
gem "turbo-rails"
gem "vite_rails"
gem "wicked_pdf"
gem "wkhtmltopdf-binary", "0.12.6.6"

group :development, :test do
  gem "capybara"
  gem "debug"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "simplecov_json_formatter", require: false
  gem "standard"
  gem "selenium-webdriver"
end

group :development do
  gem "overcommit"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
