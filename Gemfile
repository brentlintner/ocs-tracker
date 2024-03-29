source "https://rubygems.org"

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "~> 2.7.3"

gem "rails", "~> 6"
gem "pg"
gem "sass-rails", "~> 6.0"
gem "uglifier", ">= 1.3.0"
gem "turbolinks", "~> 5.2"
gem "jbuilder", "~> 2.5"
gem "hashie", "~> 4"
gem "slim-rails", "~> 3.2"
gem "webpacker", "~> 5"
gem "react-rails", "~> 2"

gem "sidekiq", "~> 6"
gem "sidekiq-scheduler", "~> 3.0"

gem "rollbar", "~> 3.1"
gem "puma", "~> 5.3"

gem "bootsnap", ">= 1.1.0", require: false

group :development, :test do
  gem "dotenv-rails"
  gem "byebug", platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem "wdm", ">= 0.1.0" if Gem.win_platform?
  gem "foreman"
  gem "awesome_print"
  gem "bundler-audit"
  gem "pry"
  gem "pry-byebug"
  gem "letter_opener"
  gem "letter_opener_web"
  gem "web-console", ">= 3.3.0"
  gem "listen", ">= 3.0.5", "< 3.2"
  gem "rspec-rails"
  gem "rspec_junit_formatter"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :test do
  gem "capybara", ">= 2.15"
  gem "selenium-webdriver"
  gem "chromedriver-helper"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
