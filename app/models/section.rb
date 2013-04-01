class Section < ActiveRecord::Base
  attr_accessible :class_number, :class_string, :dept, :desc, :instructor, :name, :section_number, :size, :spire_id, :time_slot, :requirement, :units, :room, :type

  belongs_to :time_slot
  has_one :requirement
  has_and_belongs_to_many :users

  def query_fields
    {
      :class_number => :int,
      :dept => :string,
      :desc => :string,
      :name => :string,
      :primary => :bool,
      :section_number => :string,
      :size => :int,
      :spire_id => :string,
    }
  end

  def self.for_user(user)
    # query/fetch the sections based on the user's constraints.
    sections = self.compile # invokes super's compile, could be nothing.

    # parse requirements, identify leaves that need to be retrieved.
    # the leaves should be text versions of indices into constraints.
    requirements = sections.select {|s| s.requirement}
    evaluator = BooleanExprTree(requirements)
    constraint_ids = evaluator.slots

    # now fetch all the constraints.
    constraints = Constraints.find(constraint_ids)
    # and throw them in a hash for unordered access by id
    constraints_hash = {}
    constraints.each {|constraint| constraints_hash[constraint_id] = constraint}

    # map them to each requirement, which requires all the constraints to be applied to the same section (e.g. 'dept = "CMPSCI" && num = 350 && credits > 0.0')
    requirement_slots = evaluator.expr_slots

    # Evaluate them collectively.
    constraint_result = user.satisfies_requirements?(constraints_hash, requirement_slots)

    # Now pass them into the requirement evaluator.
    satisfied = requirements.evaluate(constraint_result)

    # At this point, we can build our final list of sections.
    final = []
    sections.each_index do |idx|
      final << sections[idx] if satisfied[idx]
    end
    return final
  end
end

