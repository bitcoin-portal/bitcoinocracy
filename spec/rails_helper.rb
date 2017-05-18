ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../../config/environment', __FILE__)
abort("You're running specs in #{ENV['RAILS_ENV']} environment!") unless Rails.env.test?

require 'database_cleaner'

RSpec.configure do |config|
  config.include Rails.application.routes.url_helpers

  config.before(:each) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean
  end
end

require 'capybara/rails'
require 'capybara/poltergeist'

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(
    app,
    timeout: 60,
    phantomjs: ENV['PHANTOMJS_PATH'],
    js_errors: false
  )
end

Capybara.configure do |config|
  config.ignore_hidden_elements = true
  config.default_driver = :poltergeist
  config.javascript_driver = :poltergeist
end

require 'spec_helper'
