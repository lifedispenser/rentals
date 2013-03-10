require "test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "Admin Login Feature Test" do
  background do
    @user = FactoryGirl.create :user
  end

  scenario "should display the login form" do
    visit mr_rogers_path
    page.must_have_content "Sign in"
  end

  scenario "the dashboard should display properly", js: true do
    visit mr_rogers_path

    fill_in 'user_email', :with => @user.email
    fill_in 'user_password', :with => 'testtest'
    click_on('Sign in')

    page.must_have_content "Admin Dashboard"
  end
end
