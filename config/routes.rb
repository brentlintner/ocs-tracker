require "sidekiq/web"
require "sidekiq-scheduler/web"

Sidekiq::Web.use Rack::Auth::Basic do |username, password|
  ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(username),
    ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_USERNAME"])) &
  ActiveSupport::SecurityUtils.secure_compare(
    ::Digest::SHA256.hexdigest(password),
    ::Digest::SHA256.hexdigest(ENV["SIDEKIQ_PASSWORD"]))
end if Rails.env.production?

Rails.application.routes.draw do
  mount LetterOpenerWeb::Engine, at: "/letter_opener" if Rails.env.development?

  mount Sidekiq::Web => "admin/jobs"

  root to: "products#in_stock"

  get "manifest.json", format: "json", to: "app_manifest#spec"

  get "in-stock",     to: "products#in_stock"
  get "all-stock",    to: "products#all_stock"
  get "low-stock",    to: "products#low_stock"
  get "out-of-stock", to: "products#out_of_stock"

  get "new-products",      to: "products#new_products"
  get "recently-stocked",  to: "products#recently_stocked"
  get "recently-sold-out", to: "products#recently_sold_out"

  scope "alerts", format: "", as: :alerts do
    get  "subscribe",          to: "email_alerts#subscribe"
    post "subscribe",          to: "email_alerts#subscribe"
    get  "sent",               to: "email_alerts#sent"
    get  "confirm/:token",     to: "email_alerts#confirm", as: :confirm
    get  "unsubscribe/:token", to: "email_alerts#unsubscribe", as: :unsubscribe
  end

  get "sativa", to: "products#sativa"
  get "indica", to: "products#indica"
  get "hybrid", to: "products#hybrid"

  get "~:handle", to: "products#product_search", as: :product_search
end
