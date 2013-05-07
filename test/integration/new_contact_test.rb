require "test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "Contact Form Feature Test" do
  background do
    @rental = FactoryGirl.create(:featured_rental)
    @contacts_count = Contact.all.count
  end

  scenario "the contact form should be able to submit" do
    visit rental_path(@rental)
    click_on 'Book It'
    page.must_have_content 'Your email address is required.'
    assert_equal @contacts_count, Contact.all.count

    first_name = "John"
    last_name = "Smith"
    email = "test@example.com"
    phone = "123-456-7890"
    from = '10/10/2014'
    to = '10/15/2014'
    message = 'This looks like an amazing place.'
    
    fill_in 'contact_first_name', :with => first_name
    fill_in 'contact_last_name', :with => last_name
    fill_in 'contact_email', :with => email
    fill_in 'contact_phone', :with => phone
    fill_in 'contact_from', :with => from
    fill_in 'contact_to', :with => to
    fill_in 'contact_message', :with => message
    click_on 'Book It'
    
    contact = Contact.last
    assert_equal first_name, contact.first_name
    assert_equal last_name, contact.last_name
    assert_equal email, contact.email
    assert_equal phone, contact.phone
    assert_equal from, contact.from
    assert_equal to, contact.to
    assert_equal message, contact.message

    page.must_have_content 'Thanks for your inquiry. One of our agents will be contacting you shortly.'
    assert_equal @contacts_count + 1, Contact.all.count
  end
end