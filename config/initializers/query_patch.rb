class ActiveRecord::Base
	@@QUERY_TYPE_OPS = {
		:bool => Set.new(['=']),
		:string => Set.new(['=']),
		:real => Set.new(['!=', '>', '<', '<=', '>=']), # no '='
		:int => Set.new(['=', '!=', '>', '<', '<=', '>=']),
	}
	attr_accessor :query_fields

	def self.query_field(field, type)
		raise "invalid type: #{type}" unless @@QUERY_TYPE_OPS.include? type
		@@query_fields ||= {}
		@@query_fields[field] ||= type
	end

	# useful for, say, using integral operations on integers stored as strings.
	def typed_val(field, val)
		val = case @query_fields[field]
		when :bool
			!!val
		when :string
			"\"#{val.to_s}\""
		when :float
			val.to_f
		when :int
			val.to_i
		end
		return val unless val.nil?
		raise "cannot type value (#{val})"
	end

	def constraint(field, op, val)
		raise "invalid field to query" unless @@query_fields.include? field
		type = @@query_fields[field]
		ops = @@QUERY_TYPE_OPS[type]
		raise "invalid op (#{op}) for field #{field}" unless ops.include? op
		val = typed_val(field, val) or raise "Cannot serialize value #{val} for field #{field} of type #{type}"
		self.where("(#{field} #{op} ?)", val)
	end

	# in-memory 'query', this is basically the eval of individual operations.
	def satisfies_constraint?(constraint)
		field = constraint.field
		field_val = self.send(field)
		field_val.send(constraint.op.to_sym, typed_val(field, constraint.value))
	end
end