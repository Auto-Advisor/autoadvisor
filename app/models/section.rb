HOURS = 24
MINUTES = 60

class Section < ActiveRecord::Base
  attr_accessible :days, :gened, :instructor, :min_end, :min_start, :room, :section_number, :size, :spire_id, :ty, :units

  belongs_to :time_slot
  belongs_to :course
  has_and_belongs_to_many :users

   def self.time_str time
    hours = time / MINUTES
    minutes = time % MINUTES
    meridian = ""
    meridian = hours < 12 ? "AM" : "PM"
    hours = 12 if hours == 0
    hours -= 12 if hours > 12
    return "%02d:%02d%s" % [hours, minutes, meridian]
  end

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

  def start_s
    Section.time_str min_start
  end

  def end_s
    Section.time_str min_end
  end

  def range_s
    "#{start_s} - #{end_s}"
  end

  def time_place_s
    "#{start_s} - #{end_s} #{days}"
  end

  def self.max_time
    HOURS * MINUTES
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
      invert = constraint.include? "invert" && constraint["invert"] == true
      eq_op = invert ? "!=" : "="
      lt_op = invert ? ">" : "<="
      gt_op = invert ? "<" : ">="
      not_op = invert ? "" : "NOT"
      yes_op = invert ? "NOT" : ""
      and_op = invert ? " OR " : " AND "
      or_op = invert ? " AND " : " OR "
      case constraint["type"]
      when "major"
      query = query.where("courses.dept #{eq_op} ?", constraint["major"])
      when "c_time"
        lower = constraint["lower"]
        upper = constraint["upper"]
        query = query.where("sections.min_beg #{gt_op} ? #{and_op} sections.min_end #{lt_op} upper", lower, upper)
      when "credit"
        lower = constraint["lower"]
        upper = [constraint["upper"], 6].min
        possible = [lower..upper].to_a
        credits = possible.map {|potential| "units #{yes_op} LIKE CONCAT('_',?,'_')"}
        complete = "(%s)" % credits.join(" #{or_op} ")
        query = query.where(complete, possible.map {|i|i.to_s})
      when "num_courses"
        lower = constraint["lower"] || 0
        upper = constraint["upper"] || Section.max_time
      when "spe_course"
        # needs: to be explained?
      when "daysoff"
        daysoff = constraint["daysoff"]

        daysoff.each_char do |c|
          query = query.where("sections.days #{not_op} LIKE '%#{c}%'")
        end
      when "course_range"
        case constraint["operation"]
        when "<="
          query = query.where("courses.number #{lt_op} ?", constraint["input"].to_i)
        when ">="
          query = query.where("courses.number #{gt_op} ?", constraint["input"].to_i)
        when "="
          query = query.where("courses.number #{eq_op} ?", constraint["input"].to_i)
        end
      when "dis_lab"
        if constraint["discussion"]
          query = query.where("sections.ty #{eq_op} 'DIS'")
        end
        if constraint["lab"]
          query = query.where("sections.ty #{eq_op} 'LAB'")
        end
      when "gen"
        # gened is assumed to be a bang-separated list of codes.
        query = query.where("sections.gened #{yes_op} LIKE CONCAT('!',?,'!')", constraints["gen"])
      end
    end
    query
  end

  def self.get_new_schedule num=4
    find(:all).sample num
  end
end

