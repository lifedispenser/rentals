require 'test_helper'

describe MrRogersHelper do
  before do
    @helper = Struct.new(:controller).new
    @helper.extend(MrRogersHelper)

    @helper.controller = MiniTest::Mock.new
  end
  
  describe "admin_nav_class" do
    it "should return active" do
      @helper.controller.expect :controller_name, 'MrRogers::DashboardController'
      assert_equal 'active', @helper.admin_nav_class('dashboard')
    end

    it "should return empty string" do
      @helper.controller.expect :controller_name, 'MrRogers::RentalsController'
      assert_nil @helper.admin_nav_class('dashboard')
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
    it "should return all error help" do
      rental = Rental.create
      assert_equal "<span class='help-inline'>[\"can't be blank\", \"is too short (minimum is 2 characters)\"]</span>", @helper.input_error_help(rental, :name).strip
    end

    it "should return minimum length error help" do
      rental = Rental.create(name: 'H')
      assert_equal "<span class='help-inline'>[\"is too short (minimum is 2 characters)\"]</span>", @helper.input_error_help(rental, :name).strip
    end

    it "should return empty string" do
      rental = FactoryGirl.create :rental
      assert_nil @helper.input_error_help(rental, :name)
    end
  end
  
end
