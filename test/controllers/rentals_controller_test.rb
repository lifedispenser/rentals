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
      assert_equal @rental, assigns(:rental)
    end
    
    it "should redirect if the rental isn't published" do
      @rental.unpublish!
      get :show, id: @rental.id
      assert_response 404
      assert assigns(:rental)
      assert_equal @rental, assigns(:rental)
    end
    
  end
  
  describe "#index" do
    context "pet friendly" do
      before(:each) do
        @rental = FactoryGirl.create(:rental_with_photos, pet_friendly: true)
        @rental2 = FactoryGirl.create(:rental_with_photos, pet_friendly: true, published: false)
        FactoryGirl.create_list(:rental_with_photos, 2, pet_friendly: false)
      end
      
      it "should assign only published and pet friendly rentals" do
        get :index, pet_friendly: true
        assert_response :success
        assert assigns(:rentals)
        assert_equal [@rental], assigns(:rentals)
      end
    end

    context "kid friendly" do
      before(:each) do
        @rental = FactoryGirl.create(:rental_with_photos, kid_friendly: true)
        @rental2 = FactoryGirl.create(:rental_with_photos, kid_friendly: true, published: false)
        FactoryGirl.create_list(:rental_with_photos, 2, kid_friendly: false)
      end
      
      it "should assign only kid friendly rentals" do
        get :index, kid_friendly: true
        assert_response :success
        assert assigns(:rentals)
        assert_equal [@rental], assigns(:rentals)
      end
    end

    context "long term" do
      before(:each) do
        @rental = FactoryGirl.create(:rental_with_photos, long_term: true)
        @rental2 = FactoryGirl.create(:rental_with_photos, long_term: true, published: false)
        FactoryGirl.create_list(:rental_with_photos, 2, long_term: false)
      end
      
      it "should assign only kid friendly rentals" do
        get :index, long_term: true
        assert_response :success
        assert assigns(:rentals)
        assert_equal [@rental], assigns(:rentals)
      end
    end

    context "no filter" do
      before(:each) do
        FactoryGirl.create_list(:rental_with_photos, 2, kid_friendly: false)
        FactoryGirl.create_list(:rental_with_photos, 2, pet_friendly: false)
        @rental = FactoryGirl.create(:rental_with_photos, published: false)
      end
      
      it "should assign all published rentals" do
        get :index
        assert_response :success
        assert assigns(:rentals)
        assert_equal 4, assigns(:rentals).count
        assert_equal 4, Rental.published.count
        Rental.published.each do |r|
          assert assigns(:rentals).include? r
        end
      end
    end
  end
end
