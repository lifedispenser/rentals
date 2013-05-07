require 'test_helper'

describe ContactsController do
  context "#create" do
    before :each do
      request.env["HTTP_REFERER"] = root_path
      @rental = FactoryGirl.create :rental_with_photos
    end
    
    it "should create a new contact" do
      assert_equal 0, Contact.count
      post :create, contact: { first_name: 'Brian', last_name: 'McQuay', email: 'test@test.com', phone: '888-777-6666', message: 'This looks awesome. Is it available?', from: '10/17/2014', to: '10/19/2014', rental_id: @rental.id }
      assert_equal 1, Contact.count
      
      assert_redirected_to root_path
      assert flash[:success].present?
      
      last_email = ActionMailer::Base.deliveries.last
      refute_equal last_email, nil, "Expected an email to be sent but wasn't"
      assert last_email.to.include?("brian@onomojo.com")
      assert last_email.subject.include?("New contact")
    end
  end
end
