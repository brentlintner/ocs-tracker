namespace :sync_no_notify do
  desc "Sync or add new products from the OCS (no notifications)"
  task products: :environment do
    Product.sync_no_notify
  end
end
