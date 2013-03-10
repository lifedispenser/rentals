require "test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "Admin Dashboard Feature Test" do
  background do
    @user = FactoryGirl.create :user
    login @user
  end

  scenario "should display the admin dashboard" do
    visit mr_rogers_path
    page.must_have_content "Admin Dashboard"
  end
end
