# frozen_string_literal: true

Sentry.init do |config|
  config.dsn = ENV.fetch('SENTRY_DSN', '')
  config.breadcrumbs_logger = %i[active_support_logger http_logger]
  config.release = "#{ENV.fetch('HEROKU_RELEASE_VERSION', '')}-#{ENV.fetch('HEROKU_SLUG_DESCRIPTION', '')}"
  # Set traces_sample_rate to 1.0 to capture 100%
  # of transactions for performance monitoring.
  # We recommend adjusting this value in production.
  config.traces_sample_rate = 1.0 if Rails.env.production?
end
