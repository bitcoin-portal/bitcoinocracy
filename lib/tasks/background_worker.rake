include Rails.application.routes.url_helpers
default_url_options[:host] = ENV["HOST"]

namespace :background_worker do
  desc "TODO"
  task run: :environment do
    BackgroundWorker.new.work
  end
end
