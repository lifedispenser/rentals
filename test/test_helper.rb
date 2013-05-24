ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require "minitest/rails/shoulda"
require "minitest/rails/capybara"
require "paperclip/matchers"

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist


Capybara.register_driver :chrome do |app|
# The following doesn't work. it still creates the log file
#  Capybara::Selenium::Driver.new(app, :browser => :chrome, args: %w[--ignore-certificate-errors --disable-popup-blocking --disable-translate --silent --disable-logging])
 Capybara::Selenium::Driver.new(app, :browser => :chrome)
end

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

#Capybara.javascript_driver = :chrome
#Capybara.javascript_driver = :webkit
#Capybara.javascript_driver = :selenium

class ActiveSupport::TestCase
  ActiveRecord::Migration.check_pending!
  include Capybara::DSL
  
  self.use_transactional_fixtures = false

  before do
    if metadata[:js] == true
      DatabaseCleaner.strategy = :truncation
      Capybara.current_driver = Capybara.javascript_driver
    else
      DatabaseCleaner.strategy = :transaction
    end
    DatabaseCleaner.start
  end

  after do
    Capybara.current_driver = Capybara.default_driver
    DatabaseCleaner.clean
    Capybara.reset_sessions!
  end
  
  def login user
    visit mr_rogers_path
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: 'testtest'
    click_on('Sign in')
    page.must_have_content "Admin Dashboard"
  end
  
  def helper
    @helper ||= DummyClass.new
  end
end


class ActionController::TestCase
  include Devise::TestHelpers
end


class HelperTest < MiniTest::Spec
  include ActiveSupport::Testing::SetupAndTeardown
  include ActionView::TestCase::Behavior
  register_spec_type(/Helper$/, self)
end

class DummyClass < ActionView::Base
  # include each of your Rails helpers here
  include MrRogersHelper
end