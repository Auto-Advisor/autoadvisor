require 'test_helper'

class CreditTest < ActiveSupport::TestCase
	def c(field, op, val)
		CreditConstraint.new(:field => field, :op => op, :value => val)
	end

	test "constraint test" do
		assert credits(:data).satisfies_constraint?(c(:grade, '>', 3.0))
		assert credits(:data).satisfies_constraint?(c(:grade, '<', 3.5))
	end

end
