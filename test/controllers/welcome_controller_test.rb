require 'test_helper'

describe WelcomeController do
  context "#index" do
    it "should assign featured rentals" do
      get :index
      assert_response :success
      assert assigns(:featured_rentals)
    end
  end
end