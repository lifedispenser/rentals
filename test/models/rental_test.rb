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
      assert @rental.save == true, "Validations should pass"
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
  
end