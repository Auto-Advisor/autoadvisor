class Section < ActiveRecord::Base
  attr_accessible :instructor, :section_number, :size, :spire_id, :time_slot, :requirement, :units, :room, :ty

  belongs_to :time_slot
  belongs_to :course
  has_one :requirement
  has_and_belongs_to_many :users

  def dept
    course.dept
  end

  def name
    course.name
  end

  def number
    course.number
  end

  def class_string
    course.string
  end

  def desc
    course.desc
  end

  # fields:
  # dept (string)
  # instructor (string)
  # section_number (string)
  # spire_id (number)
  # description
  # name
  # number
  # class_string
  # units

  def as_json(options)
    {
      "class_string" => class_string,
      "dept" => dept,
      "desc" => desc || "",
      "instructor" => instructor || "",
      "name" => name,
      "number" => number,
      "section_number" => section_number,
      "spire_id" => spire_id,
      "units" => units
    }
  end

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

  def self.sections_for_constraints(constraints)
    query = Section.joins(:course)
    constraints.each do |constraint|
      case constraint["type"]
      when "major"
        query = query.where("courses.dept = ?", constraint["major"])
      when "c_time"
        # needs: section.beg, section.end
      when "credit"
        # need: sec.min_credit, sec.max_credit, or digits of possible credits.
      when "num_courses"
      when "spe_course"
        # needs: to be explained?
      when "dayoff"
        # needs: section.days
      when "course_range"
        case constraint["operation"]
        when "<="
          query = query.where("courses.number <= ?", constraint["input"].to_i)
        when ">="
          query = query.where("courses.number >= ?", constraint["input"].to_i)
        when "="
          query = query.where("courses.number = ?", constraint["input"].to_i)
        end
      when "dis_lab"
        if constraint["discussion"]
          query = query.where("sections.ty = 'DIS'")
        end
        if constraint["lab"]
          query = query.where("sections.ty = 'LAB'")
        end
      when "gen"
        # needs: section.gen
      end
    end
    query
  end

  def self.get_new_schedule num=4
    find(:all).sample num
  end
end

