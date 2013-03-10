require "test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "HomePage Feature Test" do
  background do
  end

  scenario "the homepage should display properly" do    
    visit root_path
    page.must_have_content "Surfing Langosta"
    page.wont_have_content "Admin Dashboard"

    page.must_have_selector '.carousel-inner .item', :count => 3
    page.must_have_selector '.marketing .row .span4', :count => 3
  end
end
