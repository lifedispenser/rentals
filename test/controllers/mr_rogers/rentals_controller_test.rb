require 'test_helper'

describe MrRogers::RentalsController do
  
  context "#index" do
    context "no authentication" do
      it "should redirect to signin" do
        get :index
        assert_redirected_to new_user_session_path
      end
    end
    
    context "with authentication" do
      it "should respond with a success" do
        @user = FactoryGirl.create :user
        sign_in @user
        get :index
        assert_response :success
      end
    end
  end
  

  context "#new" do
    context "no authentication" do
      it "should redirect to signin" do
        get :new
        assert_redirected_to new_user_session_path
      end
    end
    
    context "with authentication" do
      it "should respond with a success" do
        @user = FactoryGirl.create :user
        sign_in @user
        get :new
        assert_response :success
        assert assign_to(:rentals)
      end
    end
  end

  context "#create" do
    context "no authentication" do
      it "should redirect to signin" do
        post :create
        assert_redirected_to new_user_session_path
      end
    end
    
    context "with authentication" do
      before :each do
        Rental.destroy_all
        @user = FactoryGirl.create :user
        sign_in @user
      end
      
      it "should raise a parameter missing exception" do
        lambda { post :create }.must_raise ActionController::ParameterMissing
        assert_equal Rental.count, 0
      end

      it "should raise a parameter missing exception" do
        post :create, rental: { name: 'Test Name' }
        assert_response :success
        assert flash[:error]
        assert_equal Rental.count, 0
      end

      it "should raise a parameter missing exception" do
        post :create, rental: { description: 'Wonderful world' }
        assert_response :success
        assert flash[:error]
        assert_equal Rental.count, 0
      end

      it "should not create a rental and respond with a failure message" do
        post :create, rental: { name: '', description: '' }
        assert_response :success
        assert flash[:error]
        assert_equal Rental.count, 0
      end

      it "should not create a rental and respond with a failure message" do
        post :create, rental: { name: 'Test Name', description: 'Wonderful world' }
        assert_redirected_to mr_rogers_rentals_path
        assert flash[:success]
        assert_equal Rental.count, 1
      end
    end
  end
end