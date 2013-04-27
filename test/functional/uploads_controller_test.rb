require 'test_helper'

class UploadsControllerTest < ActionController::TestCase
  # test "the truth" do
  #   assert true
  # end
  setup do
    @course = credits(:data)
  end

  test "upload_credits test" do
  	get :upload_credits
  	assert_redirected_to(:controller=>'users', :action=>'transcript')
  end

  test "add_credit" do
  	get :add_credit
  	assert_redirected_to(:controller=>'users', :action=>'transcript')
  end

  #test "delete_credit" do
  #	get :delete_credit, :id=>@course 
  #	assert_redirected_to(:controller=>'users', :action=>'transcript')
  #end

  class ActiveSupport::TestCase
	include Devise::TestHelpers
  end
end
