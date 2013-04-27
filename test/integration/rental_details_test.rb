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

    selector = [:css, '.nav .active']
    page.wont_have_selector *selector
  end

  scenario "the rental details page should be accessible from the homepage photo" do
    visit root_path

    selector = [:css, '.span4 a:last-child']
    page.must_have_selector *selector

    page.find(*selector).click

    page.must_have_content @rental.name

    selector = [:css, '.nav .active']
    page.wont_have_selector *selector
  end


  scenario "the rental details page must have a link back to the homepage", js: true do
    visit rental_path(@rental)

    selector = [:css, '.nav .active']
    page.wont_have_selector *selector
    
    selector = [:css, '.nav li', {:text => 'Home'}]
    page.must_have_selector *selector
    page.find(*selector).click

    selector = [:css, '.nav .active a', {:text => 'Home'}]
    page.must_have_selector *selector
  end
end
