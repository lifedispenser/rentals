require 'test_helper'

describe Photo do
  context "validation" do
    before do
      @photo = Photo.new
    end
    
    it "should fail validation" do
      assert @photo.save == false, "Validations should fail"
      assert @photo.errors.messages[:asset].empty? == false, "Asset validation should fail"
      assert @photo.errors.messages[:rental_id].empty? == false, "Rental validation should fail"
    end

    it "should pass validation" do
      @photo.asset = File.new(Rails.root + 'test/fixtures/images/rails.png')
      @photo.rental = FactoryGirl.create :rental
      assert @photo.save == true, "Validations should pass"
    end
  end
  
  context "featured scope" do
    before do
      FactoryGirl.create_list(:photo, 5)
      @photo = FactoryGirl.create(:photo, featured: true)
    end
    
    it "should return the featured photo" do
      assert_equal Photo.featured.to_a, [@photo]
    end
  end
  
  context "banner scope" do
    before do
      FactoryGirl.create_list(:photo, 5)
      @photo = FactoryGirl.create(:photo, banner: true)
    end
    
    it "should return the banner photo" do
      assert_equal Photo.banner.to_a, [@photo]
    end
  end
  
  context "paperclip post process" do
    before do
      @photo = FactoryGirl.create(:photo)
    end
    
    it "should update rental published" do
      assert @photo.rental.published
    end
  end
  
end