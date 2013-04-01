class PastCourse < ActiveRecord::Base
  attr_accessible :year, :course_code, :course_name, :grade

  has_and_belongs_to_many :user
end
