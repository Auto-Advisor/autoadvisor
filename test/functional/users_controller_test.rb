require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:test)
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end
  
  class ActiveSupport::TestCase
    include Devise::TestHelpers
  end
end
