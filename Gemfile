source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby IO.readlines(".ruby-version")[0].strip

gem "bootsnap", ">= 1.1.0", require: false
gem "bulma-extensions-rails"
gem "bulma-rails", "~> 0.9.4"
gem "cocoon"
gem "devise"
gem "font-awesome-rails"
gem "haml-rails", "~> 2.1"
gem "jbuilder", "~> 2.11"
gem "jquery-rails"
gem "kaminari"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 6.0"
gem "pundit"
gem "rails", "~> 7.0"
gem "sentry-rails"
gem "sentry-ruby"
gem "simple_form"
gem "sprockets-rails"
gem "trix-rails", require: "trix"
gem "turbolinks", "~> 5"
gem "wicked_pdf"
gem "wkhtmltopdf-binary", "0.12.6.6"

group :development, :test do
  gem "capybara"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "pry"
  gem "rspec-rails"
  gem "rubocop"
  gem "rubocop-rails"
  gem "rubocop-rspec"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "standard"
  gem "webdrivers", "5.2.0", require: false
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.9"
  gem "overcommit"
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
