require 'test_helper'

class UploadsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @course = credits(:data)
    @user = users(:test)
  end

  test "should upload_credits" do
  	get :upload_credits
  	assert_redirected_to(:controller=>'users', :action=>'transcript')
  end

  test "should add_credit" do
  	get :add_credit, grade: 'A', course_string: 'cmpsci'
  	assert_redirected_to(:controller=>'users', :action=>'transcript')
  end

  class ActiveSupport::TestCase
	include Devise::TestHelpers
  end
end
