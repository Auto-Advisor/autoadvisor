require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  test "course exists on db" do
  	assert_not_nil(:data)
  end

  test "courses not the same on db" do
  	assert_not_equal(:data, :ai)
  end

end
