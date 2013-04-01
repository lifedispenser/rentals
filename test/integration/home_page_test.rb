require "test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "HomePage Feature Test" do
  background do
    @rental = FactoryGirl.create(:rental_with_photos)
    @photo1 = FactoryGirl.create(:photo, featured: true, rental: @rental)

    @rental2 = FactoryGirl.create(:rental_with_photos, featured_description: nil, description: Faker::Lorem.sentences(10).join(' ').to_s)
    @photo2 = FactoryGirl.create(:photo, featured: true, rental: @rental2)
  end

  scenario "the homepage should display properly" do
    visit root_path
    page.must_have_content "Surfing Langosta"
    page.wont_have_content "Admin Dashboard"

    selector = [:css, 'footer p', {:text => "#{Time.now.year} SurfingLangosta"}]
    page.must_have_selector *selector

    page.must_have_selector '.carousel-inner .item', :count => 3
    page.must_have_selector '.marketing .row .span4', :count => 2

    page.must_have_selector "img[src='#{@photo1.asset.url(:medium)}']"
    selector = [:css, '.span4 p', {:text => @rental.featured_description}]
    page.must_have_selector *selector

    page.must_have_selector "img[src='#{@photo2.asset.url(:medium)}']"
    selector = [:css, '.span4 p', {:text => @rental2.description}]
    page.wont_have_selector *selector

#    raise page.body.inspect + " AAAAA " + @rental2.description[0..255].inspect
    selector = [:css, '.span4 p', {:text => @rental2.description[0..255].strip}]
    page.must_have_selector *selector
  end
end
