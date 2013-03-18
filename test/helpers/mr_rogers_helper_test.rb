require 'test_helper'

describe MrRogersHelper do
  before do
    @helper = Struct.new(:controller).new
    @helper.extend(MrRogersHelper)

    @helper.controller = MiniTest::Mock.new
  end
  
  describe "nav_class" do
    it "should return active" do
      @helper.controller.expect :controller_name, 'MrRogers::DashboardController'
      assert_equal 'active', @helper.nav_class('dashboard')
    end

    it "should return empty string" do
      @helper.controller.expect :controller_name, 'MrRogers::RentalsController'
      assert_nil @helper.nav_class('dashboard')
    end
  end
  
  describe "input_class" do
    it "should return error" do
      rental = Rental.create
      assert_equal 'error', @helper.input_class(rental, :name)
    end

    it "should return empty string" do
      rental = FactoryGirl.create :rental
      assert_nil @helper.input_class(rental, :name)
    end
  end

  describe "input_error_help" do
    it "should return error help" do
      rental = Rental.create
      assert_equal "<span class='help-inline'>[\"can't be blank\"]</span>", @helper.input_error_help(rental, :name).strip
    end

    it "should return empty string" do
      rental = FactoryGirl.create :rental
      assert_nil @helper.input_error_help(rental, :name)
    end
  end
  
end
