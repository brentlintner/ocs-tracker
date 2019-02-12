ActionMailer::DeliveryJob.class_eval do
  include Rollbar::ActiveJob
end

class ApplicationJob < ActiveJob::Base
  include Rollbar::ActiveJob
end
