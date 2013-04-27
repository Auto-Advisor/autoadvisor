class Credit < ActiveRecord::Base
  attr_accessible :course, :grade, :points, :year, :user, :units

  belongs_to :course
  belongs_to :user

  after_update { user.recalculate_credits}
  after_destroy {|credit| credit.user.recalculate_credits}

  def string
    course.string
  end

  def number
    course.number
  end

  def name
    course.name
  end

  def trigger_gpa credit=nil
    user = credit.nil? ? self.user : credit.user
    user.recalculate_credits
  end

  def self.points_for_letter letter_grade
    grades = {
      'A+' => '4.0',
      'A' => '4.0',
      'A-' => '3.7',
      'B+' => '3.3',
      'B' => '3.0',
      'B-' => '2.7',
      'C+' => '2.3',
      'C' => '2.0',
      'C-' => '1.7',
      'D+' => '1.3',
      'D' => '1.0',
      'D-' => '0.7',
      'F' => '0.0'
    }
    BigDecimal.new(grades[letter_grade.upcase])
  end

  def self.from_course(course, year, units, grade)
    credit = Credit.new
    credit.course = course
    credit.grade = grade
    credit.units = BigDecimal.new(units) or raise "Not a valid units"
    credit.points = Credit.points_for_letter(grade) * credit.units if !grade.nil?
    credit.year = year
    credit.save
    credit
  end
end
