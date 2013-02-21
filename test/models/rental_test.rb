require 'test_helper'

describe Rental do
  context "validation" do
    before do
      @rental = Rental.new
    end
    
    it "should fail validation" do
      assert @rental.save == false, "Validations should fail"
      assert @rental.errors.messages[:name].empty? == false, "Name validation should fail"
      assert @rental.errors.messages[:description].empty? == false, "Description validation should fail"
    end

    it "should pass validation" do
      @rental.name = Faker::Lorem.words(3).to_s
      @rental.description = Faker::Lorem.sentences(2).to_s
      assert @rental.save == true, "Validations should pass"
    end
  end
end