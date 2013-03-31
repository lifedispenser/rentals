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

      it "should not create a rental and respond with a failure message" do
        post :create, rental: { name: 'Test Name' }
        assert_response :success
        assert !flash[:error].empty?
        assert_equal Rental.count, 0
      end

      it "should not create a rental and respond with a failure message" do
        post :create, rental: { description: 'Wonderful world' }
        assert_response :success
        assert !flash[:error].empty?
        assert_equal Rental.count, 0
      end

      it "should not create a rental and respond with a failure message" do
        post :create, rental: { contact: 'Someone Special' }
        assert_response :success
        assert !flash[:error].empty?
        assert_equal Rental.count, 0
      end

      it "should not create a rental and respond with a failure message" do
        post :create, rental: { name: '', description: '', contact: '' }
        assert_response :success
        assert !flash[:error].empty?
        assert_equal Rental.count, 0
      end

      it "should not create a rental and respond with a failure message" do
        post :create, rental: { name: 'Test Name', description: 'Wonderful world' }
        assert_response :success
        assert !flash[:error].empty?
        assert_equal Rental.count, 0
      end

      it "should create a rental and redirect to rentals index" do
        name = 'Test Name'
        description = 'Wonderful world'
        contact = 'Someone Special'
        post :create, rental: { name: name, description: description, contact: contact }
        
        assert_redirected_to mr_rogers_rentals_path
        assert !flash[:success].empty?
        assert_equal Rental.count, 1
        rental = Rental.all.first
        assert_equal rental.name, name
        assert_equal rental.description, description
        assert_equal rental.contact, contact
      end

      it "should create a rental and redirect to rentals index" do
        name = 'Test Name'
        featured_description = 'Perfect world'
        description = 'Wonderful world'
        contact = 'Someone Special'
        beds = '3.0'
        baths = '1.5'
        rpn = '100'
        rpw = '500'
        rpm = '2000'
        brpn = '50'
        brpw = '100'
        brpm = '200'
        post :create, rental: { name: name,
                                featured_description: featured_description,
                                description: description,
                                contact: contact,
                                bedrooms: beds,
                                bathrooms: baths,
                                pet_friendly: 'true',
                                kid_friendly: 'true',
                                rate_per_night: rpn,
                                rate_per_week: rpw,
                                rate_per_month: rpm,
                                base_rate_per_night: brpn,
                                base_rate_per_week: brpw,
                                base_rate_per_month: brpm
                                 }
        
        assert_redirected_to mr_rogers_rentals_path
        assert !flash[:success].empty?
        assert_equal Rental.count, 1
        rental = Rental.all.first
        
        assert_equal rental.name, name
        assert_equal rental.featured_description, featured_description
        assert_equal rental.description, description
        assert_equal rental.contact, contact
        assert_equal rental.pet_friendly, true
        assert_equal rental.kid_friendly, true
        assert_equal rental.bedrooms.to_s, beds
        assert_equal rental.bathrooms.to_s, baths
        assert_equal rental.rate_per_night.to_s, rpn
        assert_equal rental.rate_per_week.to_s, rpw
        assert_equal rental.rate_per_month.to_s, rpm
        assert_equal rental.base_rate_per_night.to_s, brpn
        assert_equal rental.base_rate_per_week.to_s, brpw
        assert_equal rental.base_rate_per_month.to_s, brpm
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

      it "should not update the contact because of failed validations" do
        patch :update, id: @rental.id, rental: { contact: '' }

        assert_response :success
        assert !flash[:error].empty?
        assert_equal @rental, assigns(:rental)
      end

      it "should succeed but not change anything" do
        lambda { patch :update, id: @rental.id }.must_raise ActionController::ParameterMissing
      end

      it "should update the rental information" do
        name = 'Test Name'
        featured_description = 'Perfect world'
        description = 'Wonderful world'
        contact = 'Someone Special'
        beds = '3.0'
        baths = '1.5'
        rpn = '100'
        rpw = '500'
        rpm = '2000'
        brpn = '50'
        brpw = '100'
        brpm = '200'
        patch :update, id: @rental.id, rental: {
                                                  name: name,
                                                  featured_description: featured_description,
                                                  description: description,
                                                  contact: contact,
                                                  bedrooms: beds,
                                                  bathrooms: baths,
                                                  pet_friendly: 'true',
                                                  kid_friendly: 'true',
                                                  rate_per_night: rpn,
                                                  rate_per_week: rpw,
                                                  rate_per_month: rpm,
                                                  base_rate_per_night: brpn,
                                                  base_rate_per_week: brpw,
                                                  base_rate_per_month: brpm
                                                   }
        
       assert_response :success
       assert !flash[:success].empty?
        assert_equal Rental.count, 1
        rental = Rental.all.first
        
        assert_equal rental.name, name
        assert_equal rental.featured_description, featured_description
        assert_equal rental.description, description
        assert_equal rental.contact, contact
        assert_equal rental.pet_friendly, true
        assert_equal rental.kid_friendly, true
        assert_equal rental.bedrooms.to_s, beds
        assert_equal rental.bathrooms.to_s, baths
        assert_equal rental.rate_per_night.to_s, rpn
        assert_equal rental.rate_per_week.to_s, rpw
        assert_equal rental.rate_per_month.to_s, rpm
        assert_equal rental.base_rate_per_night.to_s, brpn
        assert_equal rental.base_rate_per_week.to_s, brpw
        assert_equal rental.base_rate_per_month.to_s, brpm
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