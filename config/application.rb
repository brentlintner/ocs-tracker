require_relative "boot"

require "rails"

# Include each railties manually, excluding `active_storage/engine`
%w(
  active_record/railtie
  action_controller/railtie
  action_view/railtie
  action_mailer/railtie
  active_job/railtie
  action_cable/engine
  rails/test_unit/railtie
  sprockets/railtie
).each do |railtie|
  begin
    require railtie
  rescue LoadError
  end
end

Bundler.require(*Rails.groups)

module OcsTracker
  class Application < Rails::Application
    config.load_defaults 5.2

    config.autoload_paths += Dir[Rails.root.join("app", "workers")]

    config.action_dispatch.show_exceptions = true
    config.exceptions_app = -> (env) do
      ExceptionsController.action(:index).call(env)
    end

    config.action_controller.per_form_csrf_tokens = true

    config.active_job.queue_adapter = :sidekiq
  end
end
