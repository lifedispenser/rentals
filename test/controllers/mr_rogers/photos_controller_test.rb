require 'test_helper'

describe MrRogers::PhotosController do
  context "#index" do
    context "no authentication" do
      it "should redirect to signin" do
        get :index, :format => :json
        assert_response 401
      end
    end
    
    context "with authentication" do
      it "should respond with a success" do
        @user = FactoryGirl.create :user
        @rental = FactoryGirl.create :rental_with_photos
        sign_in @user
        get :index, :format => :json
        assert_response :success
        body = JSON.parse(response.body)
        assert body.count == 5
      end
    end
  end

  context "#show" do
    context "no authentication" do
      it "should redirect to signin" do
        get :show, id: 0, :format => :json
        assert_response 401
      end
    end
    
    context "with authentication" do
      it "should respond with a success" do
        @user = FactoryGirl.create :user
        @photo = FactoryGirl.create :photo
        sign_in @user
        get :show, id: @photo.id, :format => :json
        assert_response :success
        body = JSON.parse(response.body)
        refute_nil body['photo']
        assert body['photo']['id'] == @photo.id
      end
    end
  end

  context "#new" do
    context "no authentication" do
      it "should redirect to signin" do
        get :new, :format => :json
        assert_response 401
      end
    end
    
    context "with authentication" do
      it "should respond with a success" do
        @user = FactoryGirl.create :user
        sign_in @user
        get :new, :format => :json
        assert_response :success
        body = JSON.parse(response.body)
        refute_nil body['photo']
        assert_nil body['photo']['id']
      end
    end
  end

  context "#edit" do
    context "no authentication" do
      it "should redirect to signin" do
        get :edit, id: 0, :format => :json
        assert_response 401
      end
    end
    
    context "with authentication" do
      it "should respond with a success" do
        skip "Edit isn't in use yet"
        @user = FactoryGirl.create :user
        @photo = FactoryGirl.create :photo
        sign_in @user
        get :edit, id: @photo.id, :format => :json
        assert_response :success
        body = JSON.parse(response.body)
        refute_nil body['photo']
        assert body['photo']['id'] == @photo.id
      end
    end
  end

  context "#create" do
    context "no authentication" do
      it "should redirect to signin" do
        post :create, :format => :json
        assert_response 401
      end
    end
    
    context "with authentication" do
      it "should respond with a success" do
        @user = FactoryGirl.create :user
        @rental = FactoryGirl.create :rental
        image = fixture_file_upload 'images/rails.png', 'image/png'
        sign_in @user
        get :create, photo: { rental_id: @rental.id, asset: [image] }, :format => :json
        assert_response :success
        assert @rental.photos.count == 1
      end
    end
  end

  context "#update" do
    context "no authentication" do
      it "should redirect to signin" do
        patch :update, id: 0, :format => :json
        assert_response 401
      end
    end
    
    context "with authentication" do
      it "should respond with a success" do
        skip "Update isn't in use yet"
        @user = FactoryGirl.create :user
        @photo = FactoryGirl.create :photo
        sign_in @user
        patch :update, id: @photo.id, photo: {}, :format => :json
        assert_response :success
      end
    end
  end

  context "#destroy" do
    context "no authentication" do
      it "should redirect to signin" do
        delete :destroy, id: 0, :format => :json
        assert_response 401
      end
    end
    
    context "with authentication" do
      it "should respond with a success" do
        @user = FactoryGirl.create :user
        @photo = FactoryGirl.create :photo
        sign_in @user
        delete :destroy, id: @photo.id, :format => :json
        assert_response :success
        assert_empty Photo.all
      end
    end
  end

end