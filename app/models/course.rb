class Course < ActiveRecord::Base
  attr_accessible :dept, :desc, :hidden, :major, :name, :number, :sections, :string

  has_many :sections
  belongs_to :major

  def dept
    major.dept or ""
  end

  def self.find_or_create_dummy(major_code, num, name)
    course = Course.where("string = ?", major_code + num).first
    return course if !course.nil?
    course = Course.new
    course.major = Major.where("code = ?", major_code).first
    course.hidden = true
    course.name = name
    num_match = /(\d+)/.match(num)
    course.number = num_match.nil? ? 0 : num_match[1].to_i
    course.string = major_code + num
    course.save
    course
  end
end
