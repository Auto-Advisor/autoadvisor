require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "user exists on db" do
  	assert_not_nil(:test)
  end

end
