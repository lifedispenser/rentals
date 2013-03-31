require 'test_helper'

# To be handled correctly by Capybara this spec must end with 'Feature Test'
feature 'Admin Rental Photos Feature Test' do
  background do
    Capybara.reset_sessions!
    @user = FactoryGirl.create :user
    login @user
  end

  scenario 'should upload a new photo', js: true do
    rental = FactoryGirl.create :rental
    visit mr_rogers_rentals_path
    page.must_have_content 'All Rentals'
    page.find('.datatable tbody tr:first-child td:first-child a').click
    page.must_have_content 'Edit Rental'
    click_on 'Upload Photos'
    
    add_photos_selector = [:css, '.btn span', {:text => 'Add files...'}]
    page.must_have_selector *add_photos_selector
    add_photos_btn = page.find(*add_photos_selector)
    assert add_photos_btn.visible?

    # Hack to make the file upload field visible inside the tests.
    # jquery-fileupload-rails does the attachments via JS but its difficult to do that inside the tests
    page.execute_script("$('.fileinput-button').css('opacity','1.0').css('position','relative').show()")
    page.execute_script("$('#photo_asset').css('opacity','1.0').css('position','relative').show()")
    attach_file 'photo_asset', [(Rails.root + 'test/fixtures/images/rails.png')]

    start_upload_selector = [:css, '.start .btn span', {:text => 'Start'}]
    page.must_have_selector *start_upload_selector
    assert page.find(*start_upload_selector).visible?
    
    start_btn_selector = [:css, '.start .btn']
    page.find(*start_btn_selector).click
    (1..5).each {|i| sleep(1) unless Photo.all.count > 0}
    assert_equal 1, Photo.all.count
  end

  scenario 'should delete a photo', js: true do
    FactoryGirl.create :rental_with_photos, photo_count: 1
    visit mr_rogers_rentals_path
    page.must_have_content 'All Rentals'
    page.find('.datatable tbody tr:first-child td:first-child a').click
    page.must_have_content 'Edit Rental'

    delete_selector = [:css, '.thumbnail .btn', {:text => 'Delete'}]
    assert page.find(*delete_selector).visible?
    page.find(*delete_selector).click
    page.driver.browser.switch_to.alert.accept
    (1..5).each {|i| sleep(1) unless Photo.all.count == 0}
    assert_equal 0, Photo.all.count
  end

  scenario 'should update photo banner flag', js: true do
    FactoryGirl.create :rental_with_photos, photo_count: 1
    refute Photo.last.banner
    
    visit mr_rogers_rentals_path
    page.must_have_content 'All Rentals'
    page.find('.datatable tbody tr:first-child td:first-child a').click
    page.must_have_content 'Edit Rental'

    btn = page.find(".banner")
    assert btn.visible?, 'The banner button should be visible'
    btn.click

    (1..5).each {|i| sleep(1) unless Photo.last.banner }
    assert Photo.last.banner

    skip "The banner button click event isn't working in capybara. Maybe because its also doing a UJS AJAX call on click too."
    btn = page.find(".banner")
    refute btn.visible?, 'The banner button should be invisible'

    btn = page.find(".unbanner")
    assert btn.visible?, 'The un-banner button should be visible'
  end

  scenario 'should update photo feature flag', js: true do
    FactoryGirl.create :rental_with_photos, photo_count: 1
    refute Photo.last.banner
    
    visit mr_rogers_rentals_path
    page.must_have_content 'All Rentals'
    page.find('.datatable tbody tr:first-child td:first-child a').click
    page.must_have_content 'Edit Rental'

    btn = page.find(".feature")
    assert btn.visible?, 'The feature button should be visible'
    btn.click

    (1..5).each {|i| sleep(1) unless Photo.last.featured }
    assert Photo.last.featured

    skip "The feature button click event isn't working in capybara. Maybe because its also doing a UJS AJAX call on click too."
    btn = page.find(".feature")
    refute btn.visible?, 'The feature button should be invisible'

    btn = page.find(".unfeature")
    assert btn.visible?, 'The un-feature button should be visible'
  end


end