# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?

require 'rspec/rails'
# Add additional requires below this line. Rails is not loaded until this point!
require 'support/shoulda'
require 'support/factory_bot'
require 'support/database_cleaner'
require 'support/simplecov'
require 'support/helpers/form'

require 'support/file_spec_helper'
require 'support/carrier_wave'


begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

RSpec.configure do |config|
  config.include Warden::Test::Helpers
  config.include Helpers::Form, type: :feature

  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!

  config.filter_run focus: true
  config.run_all_when_everything_filtered = true

#<<<<<<< HEAD
#=======
#  config.include ApplicationHelper
#>>>>>>> 41006f8eef0462d82490c11565dcb3ade2d72621
end
