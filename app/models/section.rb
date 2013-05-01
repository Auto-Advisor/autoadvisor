require 'set'

HOURS = 24
MINUTES = 60

class Section < ActiveRecord::Base
  attr_accessible :credit_max, :credit_min, :days, :gened, :instructor, :min_end, :min_start, :room, :section_number, :size, :spire_id, :ty

  belongs_to :course
  has_one :major, :through => :course
  has_and_belongs_to_many :schedules

   def self.time_str time
    hours = time / MINUTES
    minutes = time % MINUTES
    meridian = ""
    meridian = hours < 12 ? "AM" : "PM"
    hours = 12 if hours == 0
    hours -= 12 if hours > 12
    return "%-d:%02d%s" % [hours, minutes, meridian]
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

  def days_s
    days.sub(/M/, "Mo").sub(/T/, "Tu").sub(/W/, "We").sub(/R/, "Th").sub(/F/, "Fr")
  end

  def time_days_s
    "#{start_s} - #{end_s} #{days_s}"
  end

  def self.max_time
    HOURS * MINUTES
  end

  def self.major_count(constraints)
    query = sections_for_constraints(constraints)[:query] or return {}
    query.joins(:course, :major).select('sections.spire_id, majors.code').group('majors.code').count
  end

  # fields:
  # class_string (string)
  # days {MTWRF}
  # dept (string)
  # gened (string)
  # id (integer)
  # major (string)
  # instructor (string)
  # section_number (string)
  # spire_id (number)
  # name
  # number
  # room
  # units

  def as_json(options={})
    {
      "class_string" => class_string,
      "credit_max" => credit_max,
      "credit_min" => credit_min,
      "days" => days,
      "dept" => dept,
      "gened" => gened,
      "id" => id,
      "instructor" => instructor || "",
      "major" => major,
      "min_start" => min_start,
      "min_end" => min_end,
      "time_start" => start_s,
      "time_end" => end_s,
      "name" => name,
      "number" => number,
      "room" => room || "",
      "section_number" => section_number,
      "spire_id" => spire_id,
    }
  end

  # format:
  # each constraint has the optional boolean 'invert' association that inverts the logic of the operation.
  # array of the following constraints:
  #   type: major
  #   major: string (e.g. 'CMPSCI')
  # 
  #   type: time
  #   lower: string: HH:MM:SS
  #   upper: string: HH:MM:SS
  #
  #   type: units "only sections worth 3 credits"
  #   lower: integer >= 0
  #   upper: integer >= 0
  #   
  #   type: target "total of 18 credits this semester, please" (or 4 classes)
  #   target_type: ("credits" | "number")
  #   lower: integer >= 0
  #   upper: integer >= 0
  #
  #   type: specified
  #   courses: [course_code]
  #   sections: [spire_id]
  #   
  #   type: days
  #   days: string e.g. "MTWRF" => sections on any day, "" => NOTHING
  #                     similarly, "MF" with invert=true => no classes on monday and friday.
  #
  #   type: course_number
  #   lower: integer >= 0
  #   upper: integer >= 0
  #
  #   type: dis
  #   discussion: boolean
  # 
  #   type: lab
  #   lab: boolean
  #
  #   type: gened
  #   string: e.g. "SBU"
  #
  #

  def for_user(user, query=nil)
    query = Section if query.nil?
    query.joins(:course).where("course.string NOT IN (?)", user.credits.joins(:course).all.map { |credit| credit.course.string })
  end

  #takes a set of constaints and generates a hash map (contents of hash map are specified below)
  def self.sections_for_constraints(constraints)
    puts constraints
    #set default restrictions
    num_lower_courses = 4
    num_upper_courses = 5
    num_lower_credits = 12
    num_upper_credits = 15
    number_restriction = false
    credit_restriction = false
    target_type = nil
    major_course_restriction = false
    max_maj_courses = nil
    min_maj_courses = nil
    major_specified = false
    major = nil
    major_query = nil
    specified_courses = Set.new
    specified_sections = Set.new
    query = Section.joins(:course, :major) #return all sections which have a course and a major
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
        #query = query.where("majors.code #{eq_op} ?", constraint["major"])
        major = constraint["major"]
        major_query = "majors.code #{eq_op} ?"
        major_specified = true
      when "major_course"
        major_course_restriction = true
        min_maj_courses = constraint["lower"] || 0
        max_maj_courses = constraint["upper"] || 0
        min_maj_courses = min_maj_courses.to_i
        max_maj_courses = max_maj_courses.to_i
      when "time"
        #if the user made a time constraint, then the upper and lower are in the format ##:##:## when they need to be
        #in minutes in the day
        lower = ((constraint["lower"][0..1].to_i)*60+(constraint["lower"][3..4].to_i)) || 0
        upper = ((constraint["upper"][0..1].to_i)*60+(constraint["lower"][3..4].to_i)) || 2599
        query = query.where("sections.min_start #{gt_op} ? #{and_op} sections.min_end #{lt_op} ?", lower, upper)
      when "units"
        lower = constraint["lower"] || 0
        upper = constraint["upper"] || 18
        query = query.where("sections.credit_min #{gt_op} ? #{and_op} sections.credit_max #{lt_op} ?", lower, upper)
      when "target"
        lower = constraint["lower"] || lower
        upper = constraint["upper"] || upper
        type = constraint["target_type"] || :number
        if type == "credits"
          num_lower_credits = lower.to_i
          num_upper_credits = upper.to_i
          credit_restriction = true
        elsif type == "number"
          num_lower_courses = lower.to_i
          num_upper_courses = upper.to_i
          number_restriction = true
        end
      when "specified"
        if constraint.include? "courses" and !constraint["courses"].empty?
          constraint["courses"].split(/\s/).each do |course_string|
            specified_courses << Course.where("string #{eq_op} ?", course_string.upper)
          end
        end
        if constraint.include? "sections" and !constraint["sections"].empty?
          constraint["sections"].each do |spire_id|
            specifed_sections << Section.where("spire_id #{eq_op} ?", spire_id)
          end
        end
      when "days_off"
        days_off = constraint["days_off"]

        days_off.each_char do |c|
          query = query.where("sections.days #{not_op} LIKE '%#{c}%'")
        end
      when "course_range"
        query = query.where("courses.number IN (?)", constraint["lower"].to_i..constraint["upper"].to_i)
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
    
    #only reduce the section set to major courses if there is a request for major courses
    #and no limit on the number of major courses
    if (not major_course_restriction and major_specified)
        query = query.where(major_query, major)
    end

    #if we have a floor but no maximum for the number of major courses, set the maximum
    #equal to the maximum number of courses
    if max_maj_courses == 0
        max_maj_courses = num_upper_courses
    end

    #this hash contains the following things:
    #:query is the set of all sections which meet the query specifications
    #:specified_courses is all the courses which the user specifically requested
    #:specified_sections is all the sections which the user specifically requested
    #:number_restriction is a flag indicating that there is a restriction on the number of
    #             courses
    #:credit_restriction is a flag indicating that there is a restriction on the number of
    #             courses
    result = {
      :query => query,
      :specified_courses => specified_courses,
      :specifed_sections => specified_sections,
      :number_restriction => number_restriction,
      :credit_restriction => credit_restriction,
      :num_lower_courses => num_lower_courses,
      :num_upper_courses => num_upper_courses,
      :num_lower_credits => num_lower_credits,
      :num_upper_credits => num_upper_credits,
      :major => major,
      :major_course_restriction => major_course_restriction,
      :min_maj_courses => min_maj_courses,
      :max_maj_courses => max_maj_courses
    }
    result
  end

  def self.get_new_schedule num=4
    find(:all).sample num
  end
end

