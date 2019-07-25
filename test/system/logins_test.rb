require "application_system_test_case"

class LoginsTest < ApplicationSystemTestCase
  # test "visiting the index" do
  #   visit logins_url
  #
  #   assert_selector "h1", text: "Login"
  # end
  test "Login on homepage" do
    visit "/"
    assert_selector "", text: "Login"
end
