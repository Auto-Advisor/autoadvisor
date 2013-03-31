class ActiveRecord::Base
	@@QUERY_TYPE_OPS = {
		:bool => Set.new(['==', '!=']),
		:string => Set.new(['==', '!=']),
		:float => Set.new(['!=', '>', '<', '<=', '>=']), # no '=='
		:int => Set.new(['==', '!=', '>', '<', '<=', '>=']),
	}

	# useful for, say, using integral operations on integers stored as strings.
	def typed_val(field, val)
		val = case self.query_fields[field]
		when :bool
			!!val
		when :string
			val.to_str
		when :float
			val.to_f
		when :int
			val.to_i
		end
		return val unless val.nil?
		raise "cannot type value (#{val})"
	end

	def param_val(field, val)
		val = case self.query_fields[field]
		when :bool
			!!val
		when :string
			"\"val.to_s\""
		when :float
			val.to_f
		when :int
			val.to_i
		end
		return val unless val.nil?
		raise "cannot type value (#{val})"
	end

	def constraint_str(field, op, val)
		raise "invalid field to query" unless query_fields.include? field
		type = self.query_fields[field]
		ops = @@QUERY_TYPE_OPS[type]
		raise "invalid op (#{op}) for field #{field}" unless ops.include? op
		val = param_val(field, val) or raise "Cannot serialize value #{val} for field #{field} of type #{type}"
		self.where("(#{field} #{op} ?)", val)
	end

	# in-memory 'query', this is basically the eval of individual operations.
	def satisfies_constraint?(constraint)
		field = constraint.field
		field_val = self.send(field)
		field_val.send constraint.op.to_sym, typed_val(field, constraint.value)
	end

	def query_fields
		self.class.query_fields
	end
end