require 'test_helper'

class SchedulesControllerTest < ActionController::TestCase
  #setup do
  #  @schedule = schedule(:test)
  #end

  test "should get schedule" do
    get :schedule
    assert :success
  end

  class ActiveSupport::TestCase
    include Devise::TestHelpers
  end

end
