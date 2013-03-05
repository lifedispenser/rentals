require 'test_helper'

describe MrRogers::DashboardController do
  
  context "#index" do
    context "no authentication" do
      it "should redirect to signin" do
        get :index
        assert_redirected_to new_user_session_path
      end
    end
    
    context "with authentication" do
      it "should show the dashboard" do
        @user = FactoryGirl.create :user
        sign_in @user
        get :index
        assert_response :success
      end
    end
  end
end