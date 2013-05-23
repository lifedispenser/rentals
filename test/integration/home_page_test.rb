require "test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "HomePage Feature Test" do
  background do
    @rental = FactoryGirl.create(:rental_with_photos)
    @photo1 = FactoryGirl.create(:photo, featured: true, rental: @rental)

    @rental2 = FactoryGirl.create(:rental_with_photos)
    @photo2 = FactoryGirl.create(:photo, featured: true, rental: @rental2)

    @rental3 = FactoryGirl.create(:rental_with_photos)
    @photo3 = FactoryGirl.create(:photo, banner: true, rental: @rental3)

    @rental4 = FactoryGirl.create(:rental_with_photos)
    @photo4 = FactoryGirl.create(:photo, banner: true, rental: @rental4)
  end

  scenario "the homepage should display properly" do
    visit root_path

    page.must_have_content "Surfing Langosta"
    page.wont_have_content "Admin Dashboard"

    selector = [:css, '.nav .active a', {:text => 'Home'}]
    page.must_have_selector *selector

    selector = [:css, 'footer p', {:text => "#{Time.now.year} SurfingLangosta"}]
    page.must_have_selector *selector

    page.must_have_selector '.carousel-inner .item', :count => 2
    page.must_have_selector '.marketing .row .span4', :count => 2

    page.must_have_selector "img[alt='rental photo #{@photo3.id}']"
    selector = [:css, '.carousel-caption h1', {:text => @rental3.name}]
    page.must_have_selector *selector
    selector = [:css, '.carousel-caption p', {:text => @rental3.description}]
    page.must_have_selector *selector

    page.must_have_selector "img[alt='rental photo #{@photo4.id}']"
    selector = [:css, '.carousel-caption h1', {:text => @rental4.name}]
    page.must_have_selector *selector
    selector = [:css, '.carousel-caption p', {:text => @rental4.description}]
    page.must_have_selector *selector
    

    page.must_have_selector "img[alt='rental photo #{@photo1.id}']"
    selector = [:css, '.span4 p', {:text => @rental.description}]
    page.must_have_selector *selector

    page.must_have_selector "img[alt='rental photo #{@photo2.id}']"
    selector = [:css, '.span4 p', {:text => @rental2.description}]
    page.must_have_selector *selector

    assert page.html.include? "UA-40474084-1"
  end
end
