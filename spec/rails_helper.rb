# Load the Rails environment
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

# Require necessary gems
require 'rspec/rails'
require 'database_cleaner'


# Configure RSpec
RSpec.configure do |config|
  config.include FactoryBot::Syntax::Methods
  config.before(:suite) do
    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
    Rails.cache.clear
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end
