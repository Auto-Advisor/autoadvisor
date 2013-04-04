class Credit < ActiveRecord::Base
  attr_accessible :course, :grade, :year, :user

  belongs_to :course
  belongs_to :user

  def string
    course.string
  end

  def number
    course.number
  end

  def name
    course.name
  end

  def self.query_fields
    {:dept => :string,
     :grade => :real,
     :name => :string,
     :number => :int,
     :year => :int}
  end

  def self.from_course(course, year, grade)
    credit = Credit.new
    credit.course = course
    credit.grade = grade
    credit.year = year
    credit.save
    credit
  end
end
