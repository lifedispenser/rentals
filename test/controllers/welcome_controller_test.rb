require 'test_helper'

describe WelcomeController do
  context "#index" do
    before :each do
      @featured_rental = FactoryGirl.create :featured_rental
      @rental = FactoryGirl.create :rental
    end
    
    it "should assign featured rentals" do
      get :index
      assert_response :success
      assert assigns(:featured_rentals)
      assert_equal assigns(:featured_rentals), [@featured_rental]
    end
  end
end
