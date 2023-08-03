source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby IO.readlines(".ruby-version")[0].strip

gem "bootsnap", require: false
gem "bulma-extensions-rails"
gem "bulma-rails"
gem "devise"
gem "haml-rails"
gem "jquery-rails"
gem "kaminari"
gem "pg"
gem "puma"
gem "pundit"
gem "rails", "~> 7.0"
gem "sentry-rails"
gem "sentry-ruby"
gem "simple_form"
gem "sprockets-rails"
gem "trix-rails", require: "trix"
gem "turbolinks"
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
  gem "webdrivers", "5.3.1", require: false
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.9"
  gem "overcommit"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
