require 'test_helper'

describe WelcomeController do
  context "#index" do
    before :each do
      FactoryGirl.create_list(:featured_rental, 7)
      FactoryGirl.create_list(:banner_rental, 7)
      @rental = FactoryGirl.create :rental
    end
    
    it "should assign featured and banner rentals" do
      get :index
      assert_response :success

      assert assigns(:featured_rentals)
      assert_equal 6, assigns(:featured_rentals).count

      assert assigns(:banner_rentals)
      assert_equal 6, assigns(:banner_rentals).count
    end
  end
end
