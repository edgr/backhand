require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit logins_url
  #
  #   assert_selector "h1", text: "Login"
  # end
  test "Login on homepage" do
    visit "/"
    assert_selector "a", text: "Login"
    click_on 'Login'
    fill_in "user_email", with: "sandyhoeger@hilll.com"
    fill_in "user_password", with: "password"
    click_on "Log in"
    save_and_open_screenshot
  end
end
