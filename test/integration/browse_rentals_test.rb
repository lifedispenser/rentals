require "test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "Browse Rentals Feature Test" do
    background do
      (1..10).each do |i|
        FactoryGirl.create_list(:rental_with_photos, 10)
      end
    end

    scenario "should display rentals" do
      visit rentals_path

      page.must_have_content "Surfing Langosta"
      page.wont_have_content "Admin Dashboard"

      selector = [:css, '.nav .active a', {:text => 'Browse'}]
      page.must_have_selector *selector

      selector = [:css, 'footer p', {:text => "#{Time.now.year} SurfingLangosta"}]
      page.must_have_selector *selector

      Rental.published.load.each do |r|
        page.must_have_selector "img[alt='rental photo #{r.photos.first.id}']"
        selector = [:css, '.span4 p', {:text => r.description}]
        page.must_have_selector *selector
      end

      assert page.html.include? "UA-40474084-1"
    end
end

