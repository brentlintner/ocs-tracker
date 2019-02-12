require "sidekiq-scheduler"

class SyncWorker
  include Sidekiq::Worker

  sidekiq_options queue: "products"

  def perform
    Product.sync
  end
end
