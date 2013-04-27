require 'test_helper'

class IntegTestTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "borwse site" do
  	get '/'
  	assert_response :success

  	get_via_redirect('/schedule')
  	assert_equal('/schedule', path, "redirected on incorrect path")

  	get_via_redirect( '/advisor')
  	assert_equal('/advisor', path, "redirected on incorrect path")

  end
end
