require 'test_helper'

class MajorTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "major exists on db" do
  	assert_not_nil(:computerScience)
  end

  test "majors not the same on db" do
  	assert_not_equal(:computerScience, :biology)
  end

end
