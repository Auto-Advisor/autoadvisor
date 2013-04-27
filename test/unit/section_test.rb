require 'test_helper'

class SectionTest < ActiveSupport::TestCase
  #test "the truth" do
   # assert true
  #end

  test "section exists on db" do
  	assert_not_nil(:CMPSCI187_01)
  end

  test "sections not the same" do
  	assert_not_equal(:CMPSCI187_D02, :CMPSCI187_01)
  end
end
