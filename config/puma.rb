workers ENV.fetch("WEB_CONCURRENCY") { 2 }.to_i

max_count = ENV.fetch("MAX_THREADS") { 5 }.to_i
min_count = ENV.fetch("MIN_THREADS") { max_count }.to_i
threads min_count, max_count

preload_app!

rackup      DefaultRackup
port        ENV["PORT"]     || 4000
environment ENV["RACK_ENV"] || "development"

on_worker_boot do
  ActiveRecord::Base.establish_connection
end
