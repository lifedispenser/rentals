require 'test_helper'

describe ApplicationHelper do
  before do
    @helper = Struct.new(:controller).new
    @helper.extend(MrRogersHelper)

    @helper.controller = MiniTest::Mock.new
  end
  
  describe "nav_class" do
    it "should return active" do
      @helper.controller.expect :controller_name, 'WelcomeController'
      assert_equal 'active', @helper.nav_class('welcome')
    end

    it "should return empty string" do
      @helper.controller.expect :controller_name, 'RentalsController'
      assert_nil @helper.nav_class('welcome')
    end
  end
end