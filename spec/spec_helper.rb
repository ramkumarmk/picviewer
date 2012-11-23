ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'


RSpec.configure do |config|
  config.mock_with :rspec
  config.use_transactional_fixtures = true
end