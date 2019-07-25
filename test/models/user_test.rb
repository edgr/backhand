require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test "full_name returns the capitalized first name and last name" do
    user = User.new(first_name: "john", last_name: "lennon")
    assert_equal "John Lennon", user.full_name
  end
  test "full_name returns the capitalized & downcased first name and last name" do
    user = User.new(first_name: "JOHN", last_name: "leNNon")
    assert_equal "John Lennon", user.full_name
  end
  test "age should be accurate" do
    user = User.new(birthday: "2007-07-24")
    assert_equal 12, user.age
  end
  test "age should not break if given today's date" do
    user = User.new(birthday: Date.today)
    assert_equal 0, user.age
  end
end
