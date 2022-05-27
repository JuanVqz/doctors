def next?
  File.basename(__FILE__) == "Gemfile.next"
end

source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby IO.readlines(".ruby-version")[0].strip

gem "bootsnap", ">= 1.1.0", require: false
gem "bulma-extensions-rails"
gem "bulma-rails", "~> 0.9.3"
gem "cocoon"
gem "devise"
gem "font-awesome-rails"
gem "haml-rails", "~> 2.0"
gem "jbuilder", "~> 2.11"
gem "jquery-rails"
gem "kaminari"
gem "pg", ">= 0.18", "< 2.0"
gem "puma", "~> 5.6"
gem "pundit"
if next?
  gem "rails", "7.0"
  gem "sprockets-rails"
else
  gem "rails", "6.1.4.6"
end
gem "simple_form"
gem "trix-rails", require: "trix"
gem "turbolinks", "~> 5"
gem "wicked_pdf"
gem "wkhtmltopdf-binary", "0.12.6.5"

group :development, :test do
  gem "capybara"
  gem "factory_bot_rails"
  gem "ffaker"
  gem "pry"
  gem "rspec-rails"
  gem "shoulda-matchers"
  gem "simplecov", require: false
  gem "standard"
  gem "webdrivers", "5.0", require: false
  gem "next_rails"
end

group :development do
  gem "listen", ">= 3.0.5", "< 3.8"
  if next?
    gem "spring", "3.0.0"
  else
    gem "spring"
  end
  gem "web-console", ">= 3.3.0"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
