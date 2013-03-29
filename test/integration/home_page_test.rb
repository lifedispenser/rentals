require "test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "HomePage Feature Test" do
  background do
    @rental = FactoryGirl.create(:rental_with_photos)
    @photo1 = FactoryGirl.create(:photo, featured: true, rental: @rental)

    @rental2 = FactoryGirl.create(:rental_with_photos)
    @photo2 = FactoryGirl.create(:photo, featured: true, rental: @rental2)
  end

  scenario "the homepage should display properly" do    
    visit root_path
    page.must_have_content "Surfing Langosta"
    page.wont_have_content "Admin Dashboard"

    page.must_have_selector '.carousel-inner .item', :count => 3
    page.must_have_selector '.marketing .row .span4', :count => 2

    page.must_have_selector "img[src='#{@photo1.asset.url(:medium)}']"
    page.must_have_selector "img[src='#{@photo2.asset.url(:medium)}']"
  end
end
