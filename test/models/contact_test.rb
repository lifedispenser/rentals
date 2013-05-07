require 'test_helper'

describe Contact do
  context "validation" do
    before do
      @contact = Contact.new
    end
    
    it "should fail all validations" do
      assert @contact.save == false, "Validations should fail"
      assert @contact.errors.messages[:email].empty? == false, "Email validation should fail"
    end

    it "should pass validation" do
      @contact.email = 'test@test.com'
      assert @contact.save == true, "Validations should pass"
    end
  end
end