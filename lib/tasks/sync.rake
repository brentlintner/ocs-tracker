namespace :sync do
  desc "Sync or add new products from the OCS"
  task products: :environment do
    Product.sync
  end
end
