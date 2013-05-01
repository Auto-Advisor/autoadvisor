require 'test_helper'

class CoursesControllerTest < ActionController::TestCase
  setup do
    @course = courses(:data)
  end

  test "should delete course" do
    Course.destroy(courses(:data))
    assert_response :success
  end

  test "should create course" do
    @newCourse = Course.create(:desc=>"",:name=>"java",:number=>121)
    assert_response :success
    assert(@newCourse.valid?, "new course not in db")
  end

  class ActiveSupport::TestCase
    include Devise::TestHelpers
  end
end
