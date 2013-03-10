require "test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "Admin Rentals Feature Test" do
  background do
    (1..20).each { FactoryGirl.create :rental }
    @user = FactoryGirl.create :user
    login @user
  end

  scenario "should display the rentals datatable", js: true do
    visit mr_rogers_rentals_path
    
    assert_equal 20, Rental.count
    new_rental_link = [:css, "a", {:text => "New"}]

    assert_have_selector page, *new_rental_link
    page.must_have_selector *new_rental_link
    
    page.must_have_content "All Rentals"
    page.must_have_selector '.datatable tbody tr', :count => 10
    page.must_have_content "Showing 1 to 10 of 20"
  end
end
