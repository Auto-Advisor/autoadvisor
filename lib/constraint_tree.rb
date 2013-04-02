class BooleanExprTree
	def slots
		return @slots
	end

	def exprs
		return @exprs
	end

	def expr_slots
		return @expr_slots
	end
	# this is a several pass operation.
	# first we build the slots, or list of referenced literals.
	# then we parse the expression, using indexes into slots instead of the literals.
	# this allows the passing of slot values into the expression separately.
	# The expressions use postfix notation for ease of implemenation.
	def initialize(exprs)
		@exprs = exprs
		@OP_AND = 1
		@OP_OR  = 2
		@op_lookup = {"^" => @OP_AND, "|" => @OP_OR}
		@trees = []
		@slots = [] # needs to have an order, uniqueness is calculated somewhere else.
		@expr_slots = []
		@slot_lookup = {}
		@exprs.each_index do |idx|
			expr = @exprs[idx]
			tokens = expr.split /\s/
			tree = []
			expr_slots = Set.new
			tokens.each do |token|
				if @op_lookup.include? token
					a = tree.pop
					b = tree.pop
					raise "Invalid expression, stack is empty" if a.nil? || b.nil?
					tree.push [@op_lookup[token], a, b]
				else
					unless @slot_lookup.include? token
						@slot_lookup[token] = @slots.length
						@slots << token
					end
					tree.push @slot_lookup[token]
					expr_slots << token
				end
			end
			@expr_slots << expr_slots
			raise "Invalid expression, >1 root (\"#{expr}\")" if tree.length > 1
			if tree.empty?
				@trees << tree
			else
				@trees << tree[0]
			end
		end
		raise "Internal error parsing expressions" unless @trees.length == @exprs.length
	end

	def evaluate(hash_vals)
		# first, rearrange them into slots.
		slots = []
		hash_vals.each_pair do |key, val|
			slots[@slot_lookup[key]] ||= val
		end
		raise "invalid slot values passed" unless slots.all? {|s| s == true || s == false}

		# then evaluate each expression individually, returning the results in order.
		@trees.collect {|expr_tree| eval_arr(expr_tree, slots)}
	end

private
	def eval_op(op, args)
		case op
		when @OP_AND
			return (args.all? {|b| b == true})
		when @OP_OR
			return (args.any? {|b| b == true})
		end
		raise "Invalid operation: #{op}"
	end

	def eval_arr(expr_arr, slot_vals)
		return true if expr_arr.empty?
		raise "Slot values length mismatch" unless slot_vals.length == @slots.length
		op = expr_arr[0]
		args = expr_arr[1..-1] || []
		app = []
		args.each_index do |idx|
			arg = args[idx]
			if arg.is_a? Array # we assume all arrays are un-eval'd expressions.
				app << eval_arr(arg, slot_vals)
			else # we look up the slot.
				app << slot_vals[arg]
			end
		end
		result = eval_op(op, app)
		return result
	end
end