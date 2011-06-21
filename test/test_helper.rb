ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
# Add this to load Capybara integration:
require 'capybara/rspec'
require 'capybara/rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
  
#Per http://trevorturk.com/2010/12/22/using-capybara-without-cucumber-in-rails-3/
#setup do
 #   Capybara.reset_sessions!
  #end
end

#class ActionController::IntegrationTest
#  include Capybara
#end
#end
