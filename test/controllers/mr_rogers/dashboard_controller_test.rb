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
    end
  end
end