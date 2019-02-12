Rollbar.configure do |config|
  # Without configuration, Rollbar is enabled in all environments.
  # To disable in specific environments, set config.enabled=false.

  config.access_token = ENV["ROLLBAR_ACCESS_TOKEN"]

  unless Rails.env.production?
    config.enabled = false
  end

  config.use_sidekiq

  # TODO: staging should set ROLLBAR_ENV
  config.environment = ENV["ROLLBAR_ENV"].presence || Rails.env
end
