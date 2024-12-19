# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.2'

gem 'bootsnap', require: false
gem 'devise'
gem 'haml-rails'
gem 'hotwire_combobox'
gem 'pagy'
gem 'pg'
gem 'puma'
gem 'rails', '~> 7.2'
gem 'sentry-rails'
gem 'sentry-ruby'
gem 'simple_form'
gem 'stimulus-rails'
gem 'trix-rails', require: 'trix'
gem 'turbo-rails'
gem 'vite_rails'
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

group :development, :test do
  gem 'capybara'
  gem 'debug'
  gem 'factory_bot_rails'
  gem 'ffaker'
  gem 'rspec-rails'
  gem 'rubocop', require: false
  gem 'selenium-webdriver'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'simplecov_json_formatter', require: false
end

group :development do
  gem 'letter_opener'
  gem 'overcommit'
end

gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

gem 'rails_stats', github: 'fastruby/rails_stats', tag: 'v2.0.0'
