# Contributing

Please submit a [Pull Request](https://github.com/brentlintner/ocs-tracker/pulls) or create an issue with a patch.

## Requirements

* [Ruby](https://www.ruby-lang.org)
* [Node.js](https://nodejs.org)
* [PostgreSQL](https://www.postgresql.org)
* [Redis](https://redis.io)

### Windows

I highly recommend using [WSL](https://docs.microsoft.com/en-us/windows/wsl/install-win10) w/ Ubuntu for a full dev env, or at least to run services like Postgres/Redis.

For purely native dev you can install the [Ruby Dev Kit](https://rubyinstaller.org/downloads/) which uses [MSYS2](http://www.msys2.org/).

## Setup

For example, on Ubuntu 18.04:
```sh
git clone https://github.com/brentlintner/ocs-tracker.git
cd ocs-tracker
curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
sudo apt-get update
sudo apt-get install -y nodejs postgresql postgresql-server-dev-all ruby ruby-dev build-essential redis
sudo service redis-server start
sudo service posgresql start
sudo -u postgres createuser -s [yourusername]
sudo -u postgres psql
\password
\q
```
Then:
```sh
npm i -g yarn
gem install bundler
sed -i -e 's/^ruby.*//g' Gemfile # ignore version constraints
bundle
yarn
touch .env
```
Add this to `.env` and fill out appropriately.
```sh
BROWSER=chrome
SMTP_DEFAULT_FROM=no-reply@ocs-tracker.app
SMTP_DEFAULT_TO=admin-email@foo.com
LOCAL_DB_USER=yourusername|postgres
LOCAL_DB_PASSWORD=dbuserpassword
REDIS_URL=redis://127.0.0.1:6379
```
## Running Locally
```sh
rake db:create
rake db:schema:load
rake sync:products
bundle exec foreman start -f Procfile.dev
```
Note: Windows native doesn't support Puma workers, so you will need to put `rails server webrick` as the `web:` command in `Procfile.dev`.

### Native App Wrappers

Uses [react-native](https://facebook.github.io/react-native).
```sh
cd native
yarn install
cd -
./bin/native-run-android
```
## Testing
```sh
rspec
```
## Deployment

Currently using these services:

* [Heroku](https://heroku.com)
* [Heroku Postgres](https://elements.heroku.com/addons/heroku-postgresql)
* [Heroku Redis](https://elements.heroku.com/addons/heroku-redis)
* [Mailgun](https://www.mailgun.com)
* [Rollbar](https://rollbar.com)
