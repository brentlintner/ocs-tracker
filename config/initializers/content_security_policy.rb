# Be sure to restart your server when you modify this file.

# Define an application-wide content security policy
# For further information see the following documentation
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy

Rails.application.config.content_security_policy do |p|
  host = ENV['SERVER_HOSTS'].split(",").first || "localhost"

  if Rails.env.development?
    p.font_src    :self, :http, :data
    p.default_src :self, :http, :unsafe_inline, :unsafe_eval
    p.connect_src :self, :http, "http://#{host}:9000", "ws://#{host}:9000"
  else
    p.font_src    :self, :https, :data
    p.script_src  :self, :https
    p.default_src :self, :https
  end
end

# If you are using UJS then enable automatic nonce generation
Rails.application.config.content_security_policy_nonce_generator = -> request { SecureRandom.base64(16) }

# Report CSP violations to a specified URI
# For further information see the following documentation:
# https://developer.mozilla.org/en-US/docs/Web/HTTP/Headers/Content-Security-Policy-Report-Only
# Rails.application.config.content_security_policy_report_only = true
