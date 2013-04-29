class Course < ActiveRecord::Base
  attr_accessible :dept, :desc, :hidden, :major, :name, :number, :sections, :string

  has_many :sections
  belongs_to :major

  def dept
    major.dept or ""
  end

  def to_str
    string
  end

  def self.create_dummy(major_code, num, course_string, name)
    course = Course.new

    course.hidden = true
    course.major = Major.where("code = ?", major_code).first
    course.name = name
    course.number = num
    course.string = course_string

    course.save
    course
  end

  def self.find_or_create_dummy(course_string, name="")
    course = Course.where("string = ?", course_string).first
    return course if !course.nil?

    num_start = course_string.index /\d/
    number = nil
    code = nil
    if num_start.nil?
      code = course_string[0..7]
      number = 0
    else
      code_end = [num_start - 1, 7].min
      code = course_string[0..code_end]
      number = /(\d)+/.match(course_string)[1]
    end

    Course.create_dummy(code, number, course_string, name)
  end
end
