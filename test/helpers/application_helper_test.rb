require 'test_helper'

describe ApplicationHelper do
  include ActionController::UrlFor
  include Rails.application.routes.url_helpers

  before do
#    default_url_options = { host: 'm.example.com' }
#    @request = MiniTest::Mock.new
#    class DummyClass < ActionView::Base
#      include Rails.application.routes.url_helpers
#      include ApplicationHelper
#    end
    @helper = DummyClass.new
    @helper.extend(ApplicationHelper)
    @helper.request = MiniTest::Mock.new
  end
  
  context "nav_class" do
    it "should return active" do
      raise root_path.inspect
      @helper.request.expect :path, 'POOP'
      assert_equal 'active', @helper.nav_class('BLAH')
#      @helper.request.expect :path, root_path
      assert_equal 'active', @helper.nav_class(root_path)
    end

    it "should return empty string" do
#      @helper.request.expect :path, root_path
      @helper.request.expect :path, 'WOOT'
      raise @helper.nav_class('poop').inspect
      assert_nil @helper.nav_class(rentals_path)
    end
    
    it "should make browse active" do
#      @helper.request.expect :path, rentals_path
      assert_equal 'active', @helper.nav_class(rentals_path)
    end
    
    it "should make pet friendly active" do
#      @helper.request.expect :path, pet_friendly_rentals_path
      assert_equal 'active', @helper.nav_class(pet_friendly_rentals_path)
    end

    it "should make kid friendly active" do
#      @helper.request.expect :path, kid_friendly_rentals_path
      assert_equal 'active', @helper.nav_class(kid_friendly_rentals_path)
    end

    it "should make long term active" do
#      @helper.request.expect :path, long_term_rentals_path
      assert_equal 'active', @helper.nav_class(long_term_rentals_path)
    end

    it "should make browse active when viewing rental details" do
      rental = FactoryGirl.create(:rental)
#      @helper.request.expect :path, rental_path(rental)
      assert_equal 'active', @helper.nav_class(rentals_path)
    end
  end
end