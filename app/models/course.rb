class Course < ActiveRecord::Base
  attr_accessible :dept, :desc, :hidden, :name, :number, :sections, :string

  has_many :sections

  def self.find_or_create_dummy(dept, num, name)
    course = Course.where("string = ?", dept + num).first
    return course if !course.nil?
    course = Course.new
    course.dept = dept
    course.hidden = true
    course.name = name
    num_match = /(\d+)/.match(num)
    course.number = num_match.nil? ? 0 : num_match[1].to_i
    course.string = dept + num
    course.save
    course
  end
end
