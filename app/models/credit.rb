class Credit < ActiveRecord::Base
  attr_accessible :dept, :grade, :name, :number, :year, :user

  has_and_belongs_to_many :user

  def self.query_fields
    {:dept => :string,
     :grade => :real,
     :name => :string,
     :number => :int,
     :year => :int}
  end

  def self.from_section(section, year, grade)
    credit = Credit.new
    credit.dept = section.dept
    credit.grade = grade
    credit.name = section.name
    credit.number = section.class_number
    credit.year = year
    credit.save
  end
end
