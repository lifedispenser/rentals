require "test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "Rental Details Feature Test" do
  background do
    @rental = FactoryGirl.create(:featured_rental)
  end

  scenario "the rental details page should be accessible from the homepage details button" do
    visit root_path

    selector = [:css, '.span4 p a:first-child']
    page.must_have_selector *selector

    page.find(*selector).click

    page.must_have_content @rental.name

    selector = [:css, '.nav .active a', {:text => 'Browse'}]
    page.must_have_selector *selector
  end

  scenario "the rental details page should be accessible from the homepage photo" do
    visit root_path

    selector = [:css, '.span4 a:last-child']
    page.must_have_selector *selector

    page.find(*selector).click

    page.must_have_content @rental.name

    selector = [:css, '.nav .active a', {:text => 'Browse'}]
    page.must_have_selector *selector
  end


  scenario "the rental details page must have a link back to the homepage", js: true do
    visit rental_path(@rental)

    selector = [:css, '.nav .active a', {:text => 'Browse'}]
    page.must_have_selector *selector
    
    selector = [:css, '.nav li', {text: 'Home'}]
    page.must_have_selector *selector
    page.find(*selector).click

    selector = [:css, '.nav a', {text: 'Home'}]
    page.must_have_selector *selector
  end
  
  scenario "the rental details page must display rental details", js: true do
    visit rental_path(@rental)

    selector = [:css, 'p', {text: @rental.bedrooms.to_s}]
    page.must_have_selector *selector

    selector = [:css, 'p', {text: @rental.bathrooms.to_s}]
    page.must_have_selector *selector

    selector = [:css, 'h1', {text: @rental.name}]
    page.must_have_selector *selector

    selector = [:css, 'h4', {text: @rental.rate_per_night}]
    page.must_have_selector *selector

    selector = [:css, 'h4', {text: @rental.rate_per_week}]
    page.must_have_selector *selector

    selector = [:css, 'h4', {text: @rental.rate_per_month}]
    page.must_have_selector *selector

    selector = [:css, 'p', {text: @rental.description}]
    page.must_have_selector *selector
  end
  
  scenario "the rental details page should 404 if rental isn't published" do
    @rental.unpublish!
    visit rental_path(@rental)
    assert_equal 404, page.status_code
  end
end
