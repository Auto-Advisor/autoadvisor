class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :gpa, :credit_hours, :grade_points

  has_many :credits
  has_and_belongs_to_many :sections
  has_and_belongs_to_many :majors

  def credit_hours
    self.credits.sum(:units)
  end

  def grade_points
    self.credits.sum(:points)
  end

  def recalculate_credits
    credits = self.credits.where("units IS NOT NULL AND grade IS NOT NULL AND units > 0")
    credit_hours = self.credit_hours = credits.sum(:units)
    grade_points = self.grade_points = credits.sum(:points)
    self.gpa = grade_points == 0 ? 0 :  grade_points / credit_hours
    save
  end

  def schedule
    self.sections
  end

  def transcript
    self.credits
  end

  def satisfies_requirements?(constraints_hash, requirement_slots)
    # pull the user's credits into memory then do the requirements queries manually.
    # Users will have few enough credits (hopefully) that this is a performance gain.
    credits = self.credits.all
    # each requirement is an array of collection IDs.
    requirements.collect do |req|
      satisfied = true
      req.each do |constraint_id|
        constraint = constraints_hash[constraint_id]
        if !credit.satisfies_constraint? constraint
          satisfied = false
          break
        end
      end
      satisfied
    end
  end

  def apply_transcript(transcript)
    lines = transcript.split /\n/
    mode = :unknown
    year = nil
    primed = false

    lines.each do |line|
      if line =~ /-\s+Test\s+Credits/i
        mode = :test
        next
      elsif line =~ /-\s+Transfer\s+Credits/i
        mode = :transfer
        next
      elsif line =~ /Beginning\s+of\s+Undergraduate\s+Record/i
        mode = :ugrad
        next
      end
      year_line = /Transferred\s+to\s+Term\s+\w+\s+(\d+)/i.match(line)
      if !year_line.nil?
        year = year_line[1]
        primed = true
        next
      end
      if mode == :transfer || mode == :test
        if year != nil && !line.empty? && primed
          primed = false
          line_parts = line.split
          major_code = line_parts[0]
          number = line_parts[1]
          name = line_parts[2..-4].join(" ")
          class_string = major_code + number
          units = line_parts[-3]
          course = Course.find_or_create_dummy(major_code, number, name) or next
          self.credits << Credit.from_course(course, year, units, nil)
        end
      #case where we are looking at part of a student's undergraduate history
      elsif mode == :ugrad
        year_line = /(Fall|Winter|Spring|Summer)\s+(\d+)/i.match(line)
        if !year_line.nil?
          year = year_line[2]
          next
        end
        if line =~ /PLAN\s+:/i
          primed = true
          next
        end
        if line =~ /TERM\s+GPA/i
          primed = false
          next
        end
        if primed
          line_parts = line.split
            #check if we've reached our current semester
            if !(line_parts[-1] =~ /^[(\d+\.\d+)PFW]/)
                return
            end
            #handle pass/fail courses
            if /^[PF]/.match(line_parts[-1])
                major_code = line_parts[0]
                number = line_parts[1]
                name = line_parts[2..-4]
                units = line_parts[-3]
                course = Course.find_or_create_dummy(major_code, number, name) or next
                self.credits << Credit.from_course(course, year, units, nil)
            elsif /^[W]/.match(line_parts[-1])
                puts "W detected"
            else
                major_code = line_parts[0]
                number = line_parts[1]
                name = line_parts[2..-5]
                units = line_parts[-4]          
                grade = line_parts[-2]
                course = Course.find_or_create_dummy(major_code, number, name) or next
                self.credits << Credit.from_course(course, year, units, grade)
            end
        end
      else
    end
  end
end
end
