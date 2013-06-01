ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/autorun'
require "minitest/rails/shoulda"
require "minitest/rails/capybara"
require "paperclip/matchers"

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  Capybara::Poltergeist::Driver.new(app, js_errors: false)
end

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
end


class ActionController::TestCase
  include Devise::TestHelpers
end

class ActionView::TestCase
end

#class MiniTest::Unit::TestCase
#  include Rails.application.routes.url_helpers
#end

#class HelperTest < MiniTest::Spec
#  include Rails.application.routes.url_helpers
#  include Capybara::DSL
  
#  include ActiveSupport::Testing::SetupAndTeardown
#  include ActionView::TestCase::Behavior
#  register_spec_type(/Helper$/, self)
#  def helper
#    @helper ||= DummyClass.new
#  end
#end

class DummyClass < ActionView::Base
  include Rails.application.routes.url_helpers
end