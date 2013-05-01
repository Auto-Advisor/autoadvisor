require 'test_helper'

class CreditTest < ActiveSupport::TestCase
	#test "constraint test" do
	#	assert true
	#end

	test "credit should exists on db" do
		assert_not_nil(:data)
	end

	test "credits should not the same on db" do
  		assert_not_equal(:data, :ai)
  	end
  	
end
