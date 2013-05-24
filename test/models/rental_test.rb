require 'test_helper'

describe Rental do
  context "validation" do
    before do
      @rental = Rental.new
    end
    
    it "should fail all validations" do
      assert @rental.save == false, "Validations should fail"
      assert @rental.errors.messages[:name].empty? == false, "Name validation should fail"
      assert @rental.errors.messages[:description].empty? == false, "Description validation should fail"
      assert @rental.errors.messages[:contact].empty? == false, "Contact validation should fail"
    end

    it "should fail description validation" do
      @rental.description = 'Hello'
      assert @rental.save == false, "Validations should fail"
      assert @rental.errors.messages[:description].empty? == false, "Description validation should fail"
    end

    it "should fail name validation" do
      @rental.name = 'H'
      assert @rental.save == false, "Validations should fail"
      assert @rental.errors.messages[:name].empty? == false, "Name validation should fail"
    end

    it "should fail contact validation" do
      @rental.description = 'Hi'
      assert @rental.save == false, "Validations should fail"
      assert @rental.errors.messages[:contact].empty? == false, "Contact validation should fail"
    end

    it "should pass validation" do
      @rental.name = Faker::Lorem.words(3).to_s
      @rental.description = Faker::Lorem.sentences(2).to_s
      @rental.contact = Faker::Lorem.sentences(2).to_s
      assert @rental.save == true, "Validations should pass: #{@rental.errors.inspect}"
    end
  end
  
  context "destroy dependent" do
    before do
      Photo.destroy_all
      @rental = FactoryGirl.create(:rental_with_photos)
    end
    
    it "should delete all associated photos" do
      assert Photo.all.count == 5
      @rental.destroy
      assert Photo.all.count == 0
    end
  end
  
  context "featured scope" do
    before do
      FactoryGirl.create_list(:rental_with_photos, 5)
      @rental = FactoryGirl.create(:rental_with_photos)
      @rental.photos << FactoryGirl.create(:photo, featured: true)
    end
    
    it "should return the rental with a featured photo" do
      assert_equal Rental.featured.to_a, [@rental]
    end
  end
  
  context "featured photo" do
    before do
      @rental = FactoryGirl.create(:rental_with_photos)
      @featured_photo1 = FactoryGirl.create(:photo, featured: true, rental: @rental)
      @featured_photo2 = FactoryGirl.create(:photo, featured: true, rental: @rental)
    end
    
    it "should return a featured photo" do
      assert [@featured_photo1, @featured_photo2].include? @rental.featured_photo
    end
  end
  
  context "banner scope" do
    before do
      FactoryGirl.create_list(:rental_with_photos, 5)
      @rental = FactoryGirl.create(:rental_with_photos)
      @rental.photos << FactoryGirl.create(:photo, banner: true)
    end
    
    it "should return the rental with a banner photo" do
      assert_equal Rental.banner.to_a, [@rental]
    end
  end
  
  context "banner photo" do
    before do
      @rental = FactoryGirl.create(:rental_with_photos)
      @banner_photo1 = FactoryGirl.create(:photo, banner: true, rental: @rental)
      @banner_photo2 = FactoryGirl.create(:photo, banner: true, rental: @rental)
    end
    
    it "should return a banner photo" do
      assert [@banner_photo1, @banner_photo2].include? @rental.banner_photo
    end
  end
  
  context "pet_friendly scope" do
    before do
      @rental = FactoryGirl.create(:rental, pet_friendly: true)
      FactoryGirl.create_list(:rental, 3, pet_friendly: false)
    end
    
    it "should return the pet friendly rentals" do
      assert_equal [@rental], Rental.pet_friendly.to_a
    end
  end

  context "kid_friendly scope" do
    before do
      @rental = FactoryGirl.create(:rental, kid_friendly: true)
      FactoryGirl.create_list(:rental, 3, kid_friendly: false)
    end
    
    it "should return the kid friendly rentals" do
      assert_equal [@rental], Rental.kid_friendly.load
    end
  end
  
  context "long_term scope" do
    before do
      @rental = FactoryGirl.create(:rental, long_term: true)
      FactoryGirl.create_list(:rental, 3, long_term: false)
    end
    
    it "should return the long term rentals" do
      assert_equal [@rental], Rental.long_term.to_a
    end
  end
  
  context "publish!" do
    before do
      @rental = FactoryGirl.create(:rental_with_photos, published: false)
      @rental2 = FactoryGirl.create(:rental, published: false)
    end
    
    it "should publish the rental" do
      @rental.publish!
      @rental.reload
      assert @rental.published
    end

    it "should not publish the rental without any photos" do
      @rental2.publish!
      @rental2.reload
      refute @rental2.published
    end
  end

  context "unpublish!" do
    before do
      @rental = FactoryGirl.create(:rental_with_photos, published: true)
    end
    
    it "should un-publish the rental" do
      @rental.unpublish!
      @rental.reload
      refute @rental.published
    end
  end
end