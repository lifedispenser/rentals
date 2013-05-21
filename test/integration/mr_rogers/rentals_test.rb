require 'test_helper'

# To be handled correctly by Capybara this spec must end with 'Feature Test'
feature 'Admin Rentals Feature Test' do
  background do
    Capybara.reset_sessions!
    @user = FactoryGirl.create :user
    login @user
  end

  scenario 'should display the rentals datatable', js: true do
    @rental = FactoryGirl.create :rental
    visit mr_rogers_rentals_path
    page.must_have_content 'All Rentals'
    page.must_have_content @rental.description
    assert false, "Need to test to make sure the other attributes show up in the datatable"
  end

  scenario 'rentals datatable should paginate correctly', js: true do
    (1..20).each { FactoryGirl.create :rental }
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
    assert_equal 1, Rental.all.count

    rental = Rental.last
    assert name, rental.name
    assert description, rental.description
    assert contact, rental.contact
  end

  scenario 'should delete a rental', js: true do
    FactoryGirl.create :rental
    assert_equal 1, Rental.all.count
    visit mr_rogers_rentals_path
    rental_count = Rental.all.count
    page.must_have_content 'All Rentals'
    
    page.find('.datatable tbody tr:first-child td:first-child a').click
    page.must_have_content 'Edit Rental'
    click_on 'Delete Rental'
    page.driver.browser.switch_to.alert.accept
    page.must_have_content 'All Rentals'
    assert_equal 0, Rental.all.count
  end

  scenario 'should update a rental', js: true do
    FactoryGirl.create :rental
    visit mr_rogers_rentals_path
    rental_count = Rental.all.count
    assert_equal 1, rental_count
    page.must_have_content 'All Rentals'
    
    page.find('.datatable tbody tr:first-child td:first-child a').click
    page.must_have_content 'Edit Rental'
    
    name = 'Wonderful Vacation Rental'
    description = 'This is the best place in the world. You will love it.'
    contact = 'Mr. Smith, 222 West Street, Some City, ST, USA, 23456 888-111-2222'
    bedrooms = '3'
    bathrooms = '2'
    rate_per_night = '111'
    rate_per_week = '2222'
    rate_per_month = '33333'
    base_rate_per_night = '1'
    base_rate_per_week = '22'
    base_rate_per_month = '333'
    
    fill_in 'rental_name', :with => name
    fill_in 'rental_description', :with => description
    fill_in 'rental_contact', :with => contact
    fill_in 'rental_bedrooms', :with => bedrooms
    fill_in 'rental_bathrooms', :with => bathrooms
    check 'rental_pet_friendly'
    check 'rental_kid_friendly'
    
    fill_in 'rental_rate_per_night', :with => rate_per_night
    fill_in 'rental_rate_per_week', :with => rate_per_week
    fill_in 'rental_rate_per_month', :with => rate_per_month
    fill_in 'rental_base_rate_per_night', :with => base_rate_per_night
    fill_in 'rental_base_rate_per_week', :with => base_rate_per_week
    fill_in 'rental_base_rate_per_month', :with => base_rate_per_month

    click_on 'Save'
    
    page.must_have_content 'Edit Rental'
    page.must_have_content 'Saved successfully'
    assert_equal 1, rental_count
    
    rental = Rental.last
    assert_equal name, rental.name
    assert_equal description, rental.description
    assert_equal contact, rental.contact
    assert_equal bedrooms.to_f, rental.bedrooms.to_f
    assert_equal bathrooms.to_f, rental.bathrooms.to_f
    assert rental.pet_friendly
    assert rental.kid_friendly
    assert_equal rate_per_night.to_i, rental.rate_per_night.to_i
    assert_equal rate_per_week.to_i, rental.rate_per_week.to_i
    assert_equal rate_per_month.to_i, rental.rate_per_month.to_i
    assert_equal base_rate_per_night.to_i, rental.base_rate_per_night.to_i
    assert_equal base_rate_per_week.to_i, rental.base_rate_per_week.to_i
    assert_equal base_rate_per_month.to_i, rental.base_rate_per_month.to_i
  end
  
  scenario 'should publish a rental', js: true do
    FactoryGirl.create :rental_with_photos, published: false
    assert_equal 1, Rental.all.count
    visit mr_rogers_rentals_path
    rental_count = Rental.all.count
    page.must_have_content 'All Rentals'
    
    page.find('.datatable tbody tr:first-child td:first-child a').click
    page.must_have_content 'Edit Rental'
    page.wont_have_content 'Published'
    click_on 'Publish'
    page.driver.browser.switch_to.alert.accept
    page.must_have_content 'Published'
    assert Rental.last.published
  end 
  
  scenario 'should un-publish a rental', js: true do
    @rental = FactoryGirl.create :rental_with_photos
    assert_equal 1, Rental.all.count
    visit mr_rogers_rentals_path
    rental_count = Rental.all.count
    page.must_have_content 'All Rentals'
    
    page.find('.datatable tbody tr:first-child td:first-child a').click
    page.must_have_content 'Edit Rental'
    page.must_have_content 'Published'
    click_on 'Un-publish'
    page.driver.browser.switch_to.alert.accept
    page.must_have_content 'Un-Published Successfully'
    @rental.reload
    refute @rental.published, "Rental should have been unpublished"
  end
end
