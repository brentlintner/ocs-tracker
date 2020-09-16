namespace :dev do
  desc "Spin up a dev server env"
  task server: :environment do
    sh "bundle exec foreman start -f Procfile.dev"
  end
end
