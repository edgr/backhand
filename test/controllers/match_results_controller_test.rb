require 'test_helper'

class MatchResultsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get match_results_create_url
    assert_response :success
  end

end
