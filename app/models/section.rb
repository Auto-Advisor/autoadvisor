require 'set'

HOURS = 24
MINUTES = 60

class Section < ActiveRecord::Base
  attr_accessible :days, :gened, :instructor, :min_end, :min_start, :room, :section_number, :size, :spire_id, :ty

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

  def major
    course.major
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
  # major (string)
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
      "major" => major,
      "name" => name,
      "number" => number,
      "section_number" => section_number,
      "spire_id" => spire_id,
      "units" => units
    }
  end

  # format:
  #   type: major
  #   major: string (e.g. 'CMPSCI')
  # 
  #   type: time
  #   lower: string: HH:MM(AM|PM)
  #   upper: string: HH:MM(AM|PM)
  #
  #   type: units
  #   lower: integer >= 0
  #   upper: integer >= 0
  #   
  #   type: target
  #   target_type: ("credits" | "number")
  #   lower: integer >= 0
  #   upper: integer >= 0
  #
  #   type: specified
  #   courses: [course_code]
  #   sections: [spire_id]
  #
  #   type: days_off
  #   days_off: string e.g. "MTWRF"
  #
  #   type: course_range
  #   lower: integer >= 0
  #   upper: integer >= 0
  #
  #   type: dis_lab
  #   discussion: boolean
  #   lab: boolean
  #
  #   type: gened
  #   string: gened code

  def self.sections_for_constraints(constraints)
    num_lower_courses = nil
    num_upper_courses = nil
    num_lower_credits = nil
    num_upper_credits = nil
    specified_courses = Set.new
    specified_sections = Set.new
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
      when "time"
        lower = constraint["lower"]
        upper = constraint["upper"]
        query = query.where("sections.min_beg #{gt_op} ? #{and_op} sections.min_end #{lt_op} ?", lower, upper)
      when "units"
        lower = constraint["lower"]
        upper = constraint["upper"]
        query = query.where("sections.credit_min #{gt_op} ? #{and_op} sections.credit_max #{lt_op}", lower, upper)
      when "target"
        lower = constraint["lower"]
        upper = constraint["upper"]
        type = constraint["target_type"]
        if type == "credits"
          num_lower_credits = lower
          num_upper_credits = upper
        elsif type == "number"
          num_lower_courses = lower
          num_upper_courses = upper
        end
      when "specified"
        constraints["courses"].each do |course_string|
          specified_courses << Course.where("string = ?", course_string)
        end
        constraints["sections"].each do |spire_id|
          specifed_sections << Section.where("spire_id = ?", spire_id)
        end
      when "days_off"
        daysoff = constraint["days_off"]

        daysoff.each_char do |c|
          query = query.where("sections.days #{not_op} LIKE '%#{c}%'")
        end
      when "course_range"
        query = query.where("courses.number IN (?)", constraint["lower"]..constraint["upper"])
      when "dis_lab"
        if constraint["discussion"]
          query = query.where("sections.ty #{eq_op} 'DIS'")
        end
        if constraint["lab"]
          query = query.where("sections.ty #{eq_op} 'LAB'")
        end
      when "gened"
        query = query.where("sections.gened #{yes_op} LIKE ?", constraints["gened"])
      end
    end
    query
  end

  def self.get_new_schedule num=4
    find(:all).sample num
  end
end

