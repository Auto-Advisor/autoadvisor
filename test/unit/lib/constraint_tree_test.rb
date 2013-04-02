require 'test_helper'
require 'constraint_tree'

class ConstraintTreeTest < ActiveSupport::TestCase
	test "empty expression" do
		tree = BooleanExprTree.new [""]
		assert tree.slots.empty?
		assert_equal tree.exprs.length, 1
		assert tree.exprs[0].empty?
		assert_equal [Set.new(tree.slots)], tree.expr_slots

		# not necessarily intuitive, but should return true.
		assert tree.evaluate({})
	end

	test "single and" do
		tree = BooleanExprTree.new ["a b ^"]
		assert_equal tree.slots.length, 2
		assert tree.slots.include?('a')
		assert tree.slots.include?('b')
		assert_equal [Set.new(tree.slots)], tree.expr_slots

		# verify the truth table
		assert_equal [false], tree.evaluate({'a' => false, 'b' => false})
		assert_equal [false], tree.evaluate({'a' => false, 'b' => true})
		assert_equal [false], tree.evaluate({'a' => true, 'b' => false})
		assert_equal [true], tree.evaluate({'a' => true, 'b' => true})
	end

	test "single or" do
		tree = BooleanExprTree.new ["a b |"]
		assert_equal tree.slots.length, 2
		assert tree.slots.include?('a')
		assert tree.slots.include?('b')
		assert_equal [Set.new(tree.slots)], tree.expr_slots

		assert_equal [false], tree.evaluate({'a' => false, 'b' => false})
		assert_equal [true],  tree.evaluate({'a' => false, 'b' => true})
		assert_equal [true],  tree.evaluate({'a' => true, 'b' => false})
		assert_equal [true],  tree.evaluate({'a' => true, 'b' => true})
	end

	test "nested and" do
		tree = BooleanExprTree.new ["a b ^ c d ^ |"]
		assert_equal tree.slots.length, 4
		assert tree.slots.include?('a')
		assert tree.slots.include?('b')
		assert tree.slots.include?('c')
		assert tree.slots.include?('d')
		assert_equal [Set.new(tree.slots)], tree.expr_slots
		def h(a,b,c,d); return {'a' => a, 'b' => b, 'c' => c, 'd' => d}; end

		assert_equal [false], tree.evaluate(h(false, false, false, false))
		assert_equal [false], tree.evaluate(h(false, true, false, false))
		assert_equal [false], tree.evaluate(h(false, false, true, false))
		assert_equal [true], tree.evaluate(h(false, false, true, true))
		assert_equal [true], tree.evaluate(h(true, true, false, true))
		assert_equal [true], tree.evaluate(h(true, true, true, true))
	end

	test "nested or" do
		tree = BooleanExprTree.new ["a b | c d | ^"]
		assert_equal tree.slots.length, 4
		assert tree.slots.include?('a')
		assert tree.slots.include?('b')
		assert tree.slots.include?('c')
		assert tree.slots.include?('d')
		assert_equal [Set.new(tree.slots)], tree.expr_slots
		def h(a,b,c,d); return {'a' => a, 'b' => b, 'c' => c, 'd' => d}; end

		assert_equal [false], tree.evaluate(h(false, false, false, false))
		assert_equal [false], tree.evaluate(h(false, true, false, false))
		assert_equal [false], tree.evaluate(h(false, false, true, false))
		assert_equal [true], tree.evaluate(h(false, true, true, false))
		assert_equal [false], tree.evaluate(h(false, false, true, true))
		assert_equal [true], tree.evaluate(h(true, true, false, true))
		assert_equal [true], tree.evaluate(h(true, true, true, true))
	end

	# useful for testing multiple expressions, number of slots
	test "entire compiled" do
		tree = BooleanExprTree.new ["", "a b |",	"c d ^",  "a b ^ c d ^ |", "c d | b a | ^"]
		assert_equal tree.slots.length, 4
		assert tree.slots.include?('a')
		assert tree.slots.include?('b')
		assert tree.slots.include?('c')
		assert tree.slots.include?('d')
		expr_slots = tree.expr_slots
		assert_equal [Set.new,
									Set.new(['a','b']),
									Set.new(['c','d']),
									Set.new(['a','b','c','d']),
									Set.new(['a','b','c','d'])], expr_slots
		def h(a,b,c,d); return {'a' => a, 'b' => b, 'c' => c, 'd' => d}; end

		# again, we run through the whole truth table, but it's much easier to generate.
		0.upto(2**4 - 1) do |bits|
			v = []
			4.times do
				v << [false, true][bits & 1]
				bits = bits >> 1
			end

			results = [true, v[0] || v[1], v[2] && v[3], (v[0] && v[1]) || (v[2] && v[3]), (v[3] || v[2]) && (v[1] || v[0])]
			assert_equal results, tree.evaluate(h(*v))
		end
	end

	test "slot reuse" do
		tree = BooleanExprTree.new ["b c ^ b a ^ |"]
		assert_equal 3, tree.slots.length
		assert tree.slots.include?('a')
		assert tree.slots.include?('b')
		assert tree.slots.include?('c')
		assert_equal [Set.new(tree.slots)], tree.expr_slots
		def h(a,b,c); return {'a' => a, 'b' => b, 'c' => c}; end

		assert_equal [false], tree.evaluate(h(false, false, false))
		assert_equal [false], tree.evaluate(h(false, true, false))
		assert_equal [false], tree.evaluate(h(true, false, true))
		assert_equal [true], tree.evaluate(h(false, true, true))
		assert_equal [true], tree.evaluate(h(true, true, false))
	end
end