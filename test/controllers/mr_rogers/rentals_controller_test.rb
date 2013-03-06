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
  
  context "#edit" do
    before :each do
      @rental = FactoryGirl.create :rental
    end

    context "no authentication" do
      it "should redirect to signin" do
        get :edit, id: @rental.id
        assert_redirected_to new_user_session_path
      end
    end
    
    context "with authentication" do
      before :each do
        @user = FactoryGirl.create :user
        sign_in @user
      end

      it "should show the edit form" do
        get :edit, id: @rental.id

        assert_response :success
        assert_equal @rental, assigns(:rental)
      end
    end
  end

  context "#update" do
    before :each do
      Rental.destroy_all
      @rental = FactoryGirl.create :rental
    end

    context "no authentication" do
      it "should redirect to signin" do
        patch :update, id: @rental.id
        assert_redirected_to new_user_session_path
      end
    end
    
    context "with authentication" do
      before :each do
        @user = FactoryGirl.create :user
        sign_in @user
      end

      it "should not update the name because of failed validations" do
        patch :update, id: @rental.id, rental: { name: '' }

        assert_response :success
        assert !flash[:error].empty?
        assert_equal @rental, assigns(:rental)
      end

      it "should not update the description because of failed validations" do
        patch :update, id: @rental.id, rental: { description: '' }

        assert_response :success
        assert !flash[:error].empty?
        assert_equal @rental, assigns(:rental)
      end

      it "should succeed but not change anything" do
        lambda { patch :update, id: @rental.id }.must_raise ActionController::ParameterMissing
      end

      it "should update the rental name" do
        new_name = 'Test Name'
        patch :update, id: @rental.id, rental: { name: new_name }
        rental = Rental.find(@rental.id)
        
        assert_response :success
        assert !flash[:success].empty?
        assert_equal rental.name, new_name
        assert_equal rental.description, @rental.description
      end

      it "should update the rental description" do
        new_description = 'Wonderful world'
        patch :update, id: @rental.id, rental: { description: new_description }
        rental = Rental.find(@rental.id)

        assert_response :success
        assert !flash[:success].empty?
        assert_equal rental.description, new_description
        assert_equal rental.name, @rental.name
      end

      it "should update the name and the description" do
        new_name = 'Test Name'
        new_description = 'Wonderful world'
        patch :update, id: @rental.id, rental: { name: new_name, description: new_description }
        
        assert_response :success
        rental = Rental.find(@rental.id)
        assert !flash[:success].empty?
        assert_equal rental.name, new_name
        assert_equal rental.description, new_description
      end
    end
  end
  
  context "#destroy" do
    before :each do
      @rental = FactoryGirl.create :rental
    end

    context "no authentication" do
      it "should redirect to signin" do
        delete :destroy, id: @rental.id
        assert_redirected_to new_user_session_path
      end
    end
    
    context "with authentication" do
      before :each do
        @user = FactoryGirl.create :user
        sign_in @user
      end

      it "should destroy the rental" do
        delete :destroy, id: @rental.id

        assert_redirected_to mr_rogers_rentals_path
        assert !flash[:success].empty?
        assert_nil Rental.where(id: @rental.id).first
      end
    end
  end
end