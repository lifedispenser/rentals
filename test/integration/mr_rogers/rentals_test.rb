require 'test_helper'

# To be handled correctly by Capybara this spec must end with 'Feature Test'
feature 'Admin Rentals Feature Test' do
  background do
    Capybara.reset_sessions!
    (1..20).each { FactoryGirl.create :rental }
    @user = FactoryGirl.create :user
    login @user
  end

  scenario 'should display the rentals datatable', js: true do
    Rental.destroy_all
    @rental = FactoryGirl.create :rental
    visit mr_rogers_rentals_path
    page.must_have_content 'All Rentals'
    page.must_have_content @rental.description
  end

  scenario 'rentals datatable should paginate correctly', js: true do
    visit mr_rogers_rentals_path
    
    page.must_have_selector '.datatable tbody tr', :count => 10
    page.must_have_content 'Showing 1 to 10 of 20'
    page.find('.next a').click
    
    page.must_have_content 'Showing 11 to 20 of 20'
    page.find('.prev a').click
    
    page.must_have_content 'Showing 1 to 10 of 20'
    page.find(:css, '.pagination ul li a', {:text => '2'}).click

    page.must_have_content 'Showing 11 to 20 of 20'
  end
  
  scenario 'should create a new rental', js: true do
    visit mr_rogers_rentals_path
    
    new_rental_link = [:css, 'a', {:text => 'New'}]
    page.must_have_selector *new_rental_link
    page.find(*new_rental_link).click
    page.must_have_content 'New Rental'
    
    name = 'Wonderful Vacation Rental'
    description = 'This is the best place in the world. You will love it.'
    contact = 'Mr. Smith, 222 West Street, Some City, ST, USA, 23456 888-111-2222'
    fill_in 'rental_name', :with => name
    fill_in 'rental_description', :with => description
    fill_in 'rental_contact', :with => contact
    click_on 'Save'
    
    page.must_have_content 'All Rentals'
    rental = Rental.last
    assert name, rental.name
    assert description, rental.description
    assert contact, rental.contact
  end

  scenario 'should delete a rental', js: true do
    visit mr_rogers_rentals_path
    rental_count = Rental.all.count
    page.must_have_content 'All Rentals'
    
    page.find('.datatable tbody tr:first-child td:first-child a').click
    page.must_have_content 'Edit Rental'
    click_on 'Delete Rental'
    page.driver.browser.switch_to.alert.accept
    page.must_have_content 'All Rentals'
    assert_not_equal rental_count, Rental.all.count
  end

  scenario 'should update a rental', js: true do
    visit mr_rogers_rentals_path
    rental_count = Rental.all.count
    page.must_have_content 'All Rentals'
    
    page.find('.datatable tbody tr:first-child td:first-child a').click
    page.must_have_content 'Edit Rental'
    
    name = 'Wonderful Vacation Rental'
    description = 'This is the best place in the world. You will love it.'
    contact = 'Mr. Smith, 222 West Street, Some City, ST, USA, 23456 888-111-2222'
    
    fill_in 'rental_name', :with => name
    fill_in 'rental_description', :with => description
    fill_in 'rental_contact', :with => contact
    click_on 'Save'
    
    page.must_have_content 'Edit Rental'
    page.must_have_content 'Saved successfully'
    rental = Rental.last
    assert name, rental.name
    assert description, rental.description
    assert contact, rental.contact
  end
end
