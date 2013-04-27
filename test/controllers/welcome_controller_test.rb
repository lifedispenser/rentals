require 'test_helper'

describe WelcomeController do
  context "#index" do
    before :each do
#      @featured_rental = FactoryGirl.create_list(:featured_rental, 10)
#      @banner_rental = FactoryGirl.create_list(:banner_rental, 10)
      (1..7).each do
        FactoryGirl.create(:featured_rental)
        FactoryGirl.create(:banner_rental)
      end
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
