require 'test_helper'

describe RentalsController do
  context "#show" do
    before :each do
      @rental = FactoryGirl.create :rental_with_photos
      FactoryGirl.create :photo, featured: true, rental: @rental
    end
    
    it "should show the rental details" do
      get :show, id: @rental.id
      assert_response :success
      assert assigns(:rental)
      assert_equal assigns(:rental), @rental
    end
  end
end
